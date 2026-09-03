/* resolve.c — turns a package name into a build-ordered list of
 * BloinkResolved nodes. No functional graph language, just a directed
 * graph walk with cycle detection, same as any other package manager
 * that isn't trying to make a philosophical point.
 */
#include "bloink.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_NODES 512

static BloinkResolved g_nodes[MAX_NODES];
static int g_n_nodes = 0;
static char g_visiting[MAX_NODES][128];
static int g_n_visiting = 0;

static BloinkResolved *find_node(const char *name) {
    for (int i = 0; i < g_n_nodes; ++i)
        if (strcmp(g_nodes[i].pkg.name, name) == 0)
            return &g_nodes[i];
    return NULL;
}

static int recipe_path_for(const char *recipe_dir, const char *name, char *out, size_t outlen) {
    char p1[BLOINK_MAX_PATH];
    snprintf(p1, sizeof(p1), "%s/%s/package.lua", recipe_dir, name);
    FILE *f = fopen(p1, "r");
    if (f) { fclose(f); snprintf(out, outlen, "%s", p1); return 0; }

    char p2[BLOINK_MAX_PATH];
    snprintf(p2, sizeof(p2), "%s/%s.lua", recipe_dir, name);
    f = fopen(p2, "r");
    if (f) { fclose(f); snprintf(out, outlen, "%s", p2); return 0; }

    return -1;
}

static BloinkResolved *resolve_one(const char *recipe_dir, const char *store_root, const char *name) {
    BloinkResolved *existing = find_node(name);
    if (existing) return existing;

    for (int i = 0; i < g_n_visiting; ++i) {
        if (strcmp(g_visiting[i], name) == 0) {
            fprintf(stderr, "bloink: dependency cycle detected at '%s'\n", name);
            return NULL;
        }
    }
    if (g_n_visiting >= MAX_NODES) return NULL;
    snprintf(g_visiting[g_n_visiting], sizeof(g_visiting[0]), "%s", name);
    g_n_visiting++;

    char path[BLOINK_MAX_PATH];
    if (recipe_path_for(recipe_dir, name, path, sizeof(path)) != 0) {
        fprintf(stderr, "bloink: no recipe found for '%s' (looked for "
                        "%s/%s/package.lua and %s/%s.lua)\n",
                name, recipe_dir, name, recipe_dir, name);
        g_n_visiting--;
        return NULL;
    }

    if (g_n_nodes >= MAX_NODES) {
        fprintf(stderr, "bloink: too many packages in closure (limit %d)\n", MAX_NODES);
        g_n_visiting--;
        return NULL;
    }
    BloinkResolved *node = &g_nodes[g_n_nodes++];
    memset(node, 0, sizeof(*node));

    if (bloink_load_recipe(path, &node->pkg) != 0) {
        g_n_nodes--;
        g_n_visiting--;
        return NULL;
    }

    /* resolve dependencies first (post-order -> correct build order) */
    char dep_hashes_buf[4096] = {0};
    for (int i = 0; i < node->pkg.n_deps; ++i) {
        BloinkResolved *d = resolve_one(recipe_dir, store_root, node->pkg.deps[i].name);
        if (!d) { g_n_visiting--; return NULL; }
        node->deps[node->n_deps++] = d;
        strncat(dep_hashes_buf, d->store_path,
                sizeof(dep_hashes_buf) - strlen(dep_hashes_buf) - 1);
    }

    bloink_store_path(&node->pkg, dep_hashes_buf, store_root, node->store_path, sizeof(node->store_path));

    g_n_visiting--;
    return node;
}

int bloink_resolve(const char *recipe_dir, const char *store_root, const char *name, BloinkResolved **out_list, int *out_count) {
    g_n_nodes = 0;
    g_n_visiting = 0;

    BloinkResolved *root = resolve_one(recipe_dir, store_root, name);
    if (!root) return -1;

    *out_list = g_nodes;
    *out_count = g_n_nodes;
    return 0;
}
