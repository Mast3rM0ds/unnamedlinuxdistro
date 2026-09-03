/* profile.c — profiles are just a directory of symlinks into the store,
 * e.g. /bloink/profiles/default/bin/foo -> /bloink/store/<hash>-foo-1.0/bin/foo
 * Activating a profile means putting that directory on $PATH. There is
 * no daemon, no database beyond the filesystem itself, and switching or
 * rolling back a profile is `ln -sfn` to a different generation dir —
 * exactly the part of Nix worth keeping, with none of the rest.
 */
#include "bloink.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <dirent.h>

static int mkdir_p2(const char *path) {
    char tmp[BLOINK_MAX_PATH];
    snprintf(tmp, sizeof(tmp), "%s", path);
    for (char *p = tmp + 1; *p; ++p) {
        if (*p == '/') { *p = 0; mkdir(tmp, 0755); *p = '/'; }
    }
    mkdir(tmp, 0755);
    return 0;
}

static void link_tree(const char *store_subdir, const char *profile_subdir) {
    DIR *d = opendir(store_subdir);
    if (!d) return;
    mkdir_p2(profile_subdir);
    struct dirent *ent;
    while ((ent = readdir(d)) != NULL) {
        if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0) continue;
        char src[BLOINK_MAX_PATH], dst[BLOINK_MAX_PATH];
        snprintf(src, sizeof(src), "%s/%s", store_subdir, ent->d_name);
        snprintf(dst, sizeof(dst), "%s/%s", profile_subdir, ent->d_name);
        struct stat st;
        if (stat(src, &st) == 0 && S_ISDIR(st.st_mode)) {
            /* only recurse one extra level (e.g. share/applications);
             * top-level bin/lib/share/etc are merged, individual files
             * inside are symlinked directly so later packages can add
             * more files to the same directory without conflict */
            link_tree(src, dst);
        } else {
            unlink(dst); /* last one wins, same as PATH ordering would */
            symlink(src, dst);
        }
    }
    closedir(d);
}

int bloink_profile_link(const char *profile_dir, BloinkResolved *r) {
    mkdir_p2(profile_dir);
    const char *dirs[] = {"bin", "lib", "share", "include", "etc"};
    for (size_t i = 0; i < sizeof(dirs)/sizeof(dirs[0]); ++i) {
        char store_sub[BLOINK_MAX_PATH], profile_sub[BLOINK_MAX_PATH];
        snprintf(store_sub, sizeof(store_sub), "%s/%s", r->store_path, dirs[i]);
        snprintf(profile_sub, sizeof(profile_sub), "%s/%s", profile_dir, dirs[i]);
        link_tree(store_sub, profile_sub);
    }
    for (int i = 0; i < r->n_deps; ++i)
        bloink_profile_link(profile_dir, r->deps[i]);
    return 0;
}
