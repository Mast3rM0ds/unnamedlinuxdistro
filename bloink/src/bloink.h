/* bloink.h — core types for the bloink package manager
 *
 * bloink is deliberately small. There is no daemon, no VM, no functional
 * purity model, no mandatory init system. It is a static-linked, musl-first
 * package manager that resolves and builds packages described in real Lua
 * (not a bespoke DSL), installs them into a content-addressed store, and
 * activates them via plain symlink profiles.
 */
#ifndef BLOINK_H
#define BLOINK_H

#include <stddef.h>

#define BLOINK_VERSION      "0.1.0"
#define BLOINK_STORE_DEFAULT "/bloink/store"
#define BLOINK_PROFILES_DEFAULT "/bloink/profiles"
#define BLOINK_RECIPES_DEFAULT "/bloink/recipes"
#define BLOINK_CACHE_DEFAULT "/bloink/cache"
#define BLOINK_MAX_DEPS 64
#define BLOINK_MAX_SOURCES 8
#define BLOINK_MAX_STEPS 64
#define BLOINK_MAX_PATH 4096

typedef struct {
    char url[1024];
    char sha256[65];       /* hex digest, required — no unverified fetches */
    char dest[256];        /* relative path inside $src, default: basename(url) */
} BloinkSource;

typedef struct {
    char name[128];
    char constraint[64];   /* e.g. ">=1.2", "*", empty = any */
    int  build_only;       /* 1 = not linked into runtime closure */
} BloinkDep;

typedef struct {
    char name[128];
    char version[64];
    char description[512];
    char license[64];
    char homepage[256];

    BloinkSource sources[BLOINK_MAX_SOURCES];
    int n_sources;

    BloinkDep deps[BLOINK_MAX_DEPS];
    int n_deps;

    /* build.sh-equivalent: an ordered list of shell command lines,
     * executed with $out, $src, and every dependency's store path
     * exported as BLOINK_DEP_<NAME> in the environment. */
    char steps[BLOINK_MAX_STEPS][2048];
    int n_steps;

    /* optional: recipe-declared service description, consumed by
     * whatever init adapter the running system uses. bloink itself
     * never parses or acts on this beyond storing it verbatim. */
    char service[2048];
    int has_service;

    char recipe_path[BLOINK_MAX_PATH];
} BloinkPackage;

/* store.c */
int  bloink_store_path(const BloinkPackage *pkg, const char *deps_hash, const char *store_root, char *out, size_t outlen);
int  bloink_store_exists(const char *store_path);

/* lua_recipe.c */
int  bloink_load_recipe(const char *path, BloinkPackage *out);

/* resolve.c */
typedef struct BloinkResolved {
    BloinkPackage pkg;
    char store_path[BLOINK_MAX_PATH];
    struct BloinkResolved *deps[BLOINK_MAX_DEPS];
    int n_deps;
    int built;
} BloinkResolved;

int bloink_resolve(const char *recipe_dir, const char *store_root, const char *name, BloinkResolved **out_list, int *out_count);

/* build.c */
int bloink_build(BloinkResolved *r, const char *store_root, const char *cache_root);

/* profile.c */
int bloink_profile_link(const char *profile_dir, BloinkResolved *r);

#endif
