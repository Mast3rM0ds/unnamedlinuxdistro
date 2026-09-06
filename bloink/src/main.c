#include "bloink.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const char *env_or(const char *name, const char *fallback) {
  const char *v = getenv(name);
  return v ? v : fallback;
}

static void print_usage(void) {
  fprintf(
      stderr,
      "bloink %s — bloinks bloinkery pkg mgr\n\n"
      "usage:\n"
      "  bloink build <name>              build package and its dependencies\n"
      "  bloink install <name> [profile]  build and link into a profile\n"
      "  bloink show <name>               show recipe info\n"
      "  bloink list                      list recipes\n",
      BLOINK_VERSION);
}

static void print_resolved(BloinkResolved *r, int depth) {
  for (int i = 0; i < depth; ++i)
    fprintf(stderr, "  ");
  fprintf(stderr, "%s-%s  %s\n", r->pkg.name, r->pkg.version, r->store_path);
}

int main(int argc, char **argv) {
  if (argc < 2) {
    print_usage();
    return 1;
  }

  const char *recipes = env_or("BLOINK_RECIPES", BLOINK_RECIPES_DEFAULT);
  const char *store = env_or("BLOINK_STORE", BLOINK_STORE_DEFAULT);
  const char *profiles = env_or("BLOINK_PROFILES", BLOINK_PROFILES_DEFAULT);
  const char *cache = env_or("BLOINK_CACHE", BLOINK_CACHE_DEFAULT);

  if (strcmp(argv[1], "build") == 0 || strcmp(argv[1], "install") == 0) {
    if (argc < 3) {
      print_usage();
      return 1;
    }
    BloinkResolved *list;
    int n;
    if (bloink_resolve(recipes, store, argv[2], &list, &n) != 0)
      return 1;

    BloinkResolved *root = NULL;
    for (int i = 0; i < n; ++i)
      if (strcmp(list[i].pkg.name, argv[2]) == 0)
        root = &list[i];
    if (!root) {
      fprintf(stderr, "bloink: internal error resolving %s\n", argv[2]);
      return 1;
    }

    if (bloink_build(root, store, cache) != 0)
      return 1;

    if (strcmp(argv[1], "install") == 0) {
      const char *profile_name = argc > 3 ? argv[3] : "default";
      char profile_dir[BLOINK_MAX_PATH];
      snprintf(profile_dir, sizeof(profile_dir), "%s/%s", profiles,
               profile_name);
      if (bloink_profile_link(profile_dir, root) != 0)
        return 1;
      fprintf(stderr, "bloink: linked into profile '%s' -> %s\n", profile_name,
              profile_dir);
      fprintf(stderr,
              "bloink: please add path:  export PATH=\"%s/bin:$PATH\"\n",
              profile_dir);
    }
    return 0;
  }

  if (strcmp(argv[1], "show") == 0) {
    if (argc < 3) {
      print_usage();
      return 1;
    }
    BloinkResolved *list;
    int n;
    if (bloink_resolve(recipes, store, argv[2], &list, &n) != 0)
      return 1;
    BloinkResolved *root = NULL;
    for (int i = 0; i < n; ++i)
      if (strcmp(list[i].pkg.name, argv[2]) == 0)
        root = &list[i];
    printf("name:        %s\n", root->pkg.name);
    printf("version:     %s\n", root->pkg.version);
    printf("description: %s\n", root->pkg.description);
    printf("license:     %s\n", root->pkg.license);
    printf("homepage:    %s\n", root->pkg.homepage);
    printf("store path:  %s\n", root->store_path);
    printf("deps:\n");
    for (int i = 0; i < root->n_deps; ++i)
      printf("  - %s-%s\n", root->deps[i]->pkg.name,
             root->deps[i]->pkg.version);
    return 0;
  }

  if (strcmp(argv[1], "list") == 0) {
    char cmd[BLOINK_MAX_PATH + 64];
    snprintf(cmd, sizeof(cmd),
             "find '%s' -name package.lua -printf '%%h\\n' 2>/dev/null | xargs "
             "-r -n1 basename | sort; "
             "find '%s' -maxdepth 1 -name '*.lua' 2>/dev/null | xargs -r -n1 "
             "basename -s .lua | sort",
             recipes, recipes);
    return system(cmd) == 0 ? 0 : 1;
  }

  print_usage();
  return 1;
}
