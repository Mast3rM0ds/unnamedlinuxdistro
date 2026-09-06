// hi there its fucking bloink again let me explain what this is
// so bloink is nix but on steroids essentially no bloat
// but because of it trying to be nix but better we still need profiles!
// and you might be thinking "well bloink what is a profile?" well
// im here to answer that, when ever you install/build a package
// it makes a new profile with that package and adds into PATH
// if its bloink install thats been run we would automatically add
// the new profile into PATH
// if its only build we wont do that and it will only build it
// but still make a profile for it!
#include "bloink.h"
#include <dirent.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static int mkdir_p2(const char *path) {
  char tmp[BLOINK_MAX_PATH];
  snprintf(tmp, sizeof(tmp), "%s", path);
  for (char *p = tmp + 1; *p; ++p) {
    if (*p == '/') {
      *p = 0;
      mkdir(tmp, 0755);
      *p = '/';
    }
  }
  mkdir(tmp, 0755);
  return 0;
}

static void link_tree(const char *store_subdir, const char *profile_subdir) {
  DIR *d = opendir(store_subdir);
  if (!d)
    return;
  mkdir_p2(profile_subdir);
  struct dirent *ent;
  while ((ent = readdir(d)) != NULL) {
    if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
      continue;
    char src[BLOINK_MAX_PATH], dst[BLOINK_MAX_PATH];
    snprintf(src, sizeof(src), "%s/%s", store_subdir, ent->d_name);
    snprintf(dst, sizeof(dst), "%s/%s", profile_subdir, ent->d_name);
    struct stat st;
    if (stat(src, &st) == 0 && S_ISDIR(st.st_mode)) {
      link_tree(src, dst);
    } else {
      unlink(dst);
      symlink(src, dst);
    }
  }
  closedir(d);
}

int bloink_profile_link(const char *profile_dir, BloinkResolved *r) {
  mkdir_p2(profile_dir);
  const char *dirs[] = {"bin", "lib", "share", "include", "etc"};
  for (size_t i = 0; i < sizeof(dirs) / sizeof(dirs[0]); ++i) {
    char store_sub[BLOINK_MAX_PATH], profile_sub[BLOINK_MAX_PATH];
    snprintf(store_sub, sizeof(store_sub), "%s/%s", r->store_path, dirs[i]);
    snprintf(profile_sub, sizeof(profile_sub), "%s/%s", profile_dir, dirs[i]);
    link_tree(store_sub, profile_sub);
  }
  for (int i = 0; i < r->n_deps; ++i)
    bloink_profile_link(profile_dir, r->deps[i]);
  return 0;
}
