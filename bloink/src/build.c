/* build.c — fetch verified sources, run the recipe's build steps with a
 * plain POSIX shell, install into the content-addressed store.
 *
 * Deliberately NOT sandboxed by default: bloink trusts the sha256 pin on
 * each source and runs `sh -c` for each step, same as a shell script
 * you'd write yourself. If you want stronger isolation, wrap `bloink
 * build` in bubblewrap/unshare/whatever you already use — that's a
 * system-level choice, not something the package manager should force
 * on you. (See docs/PHILOSOPHY.md: "we like choice".)
 */
#include "bloink.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>

static int run_cmd(const char *cmd) {
    fprintf(stderr, "  $ %s\n", cmd);
    int rc = system(cmd);
    if (rc == -1) return -1;
    if (WIFEXITED(rc)) return WEXITSTATUS(rc);
    return -1;
}

static int mkdir_p(const char *path) {
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

static int fetch_sources(const BloinkPackage *pkg, const char *cache_root, const char *src_dir) {
    for (int i = 0; i < pkg->n_sources; ++i) {
        const BloinkSource *s = &pkg->sources[i];
        char cache_file[BLOINK_MAX_PATH];
        snprintf(cache_file, sizeof(cache_file), "%s/%s", cache_root, s->sha256);

        struct stat st;
        if (stat(cache_file, &st) != 0) {
            mkdir_p(cache_root);
            /* wget instead of curl: some minimal/musl base systems (this
             * distro included) don't ship curl or a working ca-certificates
             * bundle out of the box. --no-check-certificate skips TLS cert
             * validation, which sounds scary, but the actual integrity
             * check here is the sha256 pin verified right below — that's
             * what decides whether the bytes are trusted, not the TLS
             * handshake. If your system has real certs, drop that flag. */
            char cmd[BLOINK_MAX_PATH * 2];
            snprintf(cmd, sizeof(cmd),
                     "wget -q --no-check-certificate --tries=3 -O '%s.part' '%s' && mv '%s.part' '%s'",
                     cache_file, s->url, cache_file, cache_file);
            if (run_cmd(cmd) != 0) {
                fprintf(stderr, "bloink: failed to fetch %s\n", s->url);
                return -1;
            }
        }

        /* verify */
        char verify[BLOINK_MAX_PATH * 2];
        snprintf(verify, sizeof(verify),
                 "echo '%s  %s' | sha256sum -c - >/dev/null 2>&1",
                 s->sha256, cache_file);
        if (system(verify) != 0) {
            fprintf(stderr, "bloink: sha256 mismatch for %s — refusing to use it "
                            "(expected %s)\n", s->url, s->sha256);
            return -1;
        }

        /* extract (or copy) into src_dir. Don't trust the URL's file
         * extension for the archive type (e.g. GitHub's codeload URLs
         * carry no extension at all) — sniff the actual file instead,
         * and let GNU tar auto-detect the compression. */
        char cmd[BLOINK_MAX_PATH * 2];
        const char *url = s->url;
        char magic[8] = {0};
        FILE *mf = fopen(cache_file, "rb");
        if (mf) { size_t got = fread(magic, 1, sizeof(magic), mf); (void)got; fclose(mf); }

        int is_gzip = (unsigned char)magic[0]==0x1f && (unsigned char)magic[1]==0x8b;
        int is_xz   = (unsigned char)magic[0]==0xfd && magic[1]=='7' && magic[2]=='z';
        int is_bz2  = magic[0]=='B' && magic[1]=='Z' && magic[2]=='h';
        int is_zip  = magic[0]=='P' && magic[1]=='K';
        int is_tar_like = is_gzip || is_xz || is_bz2 ||
            (strstr(url, ".tar") != NULL) ||
            (magic[257]=='u' && magic[258]=='s' && magic[259]=='t' && magic[260]=='a' && magic[261]=='r');

        if (is_zip)
            snprintf(cmd, sizeof(cmd), "cd '%s' && unzip -q '%s' && shopt -s dotglob 2>/dev/null; "
                     "d=$(ls -d */ | head -1); mv \"$d\"* . 2>/dev/null; true",
                     src_dir, cache_file);
        else if (is_tar_like)
            snprintf(cmd, sizeof(cmd), "tar xf '%s' -C '%s' --strip-components=1", cache_file, src_dir);
        else
            snprintf(cmd, sizeof(cmd), "cp '%s' '%s/'", cache_file, src_dir);

        if (run_cmd(cmd) != 0) {
            fprintf(stderr, "bloink: failed to unpack %s\n", url);
            return -1;
        }
    }
    return 0;
}

int bloink_build(BloinkResolved *r, const char *store_root, const char *cache_root) {
    if (r->built) return 0;
    (void)store_root;

    /* dependencies first */
    for (int i = 0; i < r->n_deps; ++i) {
        if (bloink_build(r->deps[i], store_root, cache_root) != 0)
            return -1;
    }

    if (bloink_store_exists(r->store_path)) {
        fprintf(stderr, "bloink: %s already built -> %s\n", r->pkg.name, r->store_path);
        r->built = 1;
        return 0;
    }

    fprintf(stderr, "bloink: building %s-%s\n", r->pkg.name, r->pkg.version);

    char work_dir[BLOINK_MAX_PATH];
    snprintf(work_dir, sizeof(work_dir), "/tmp/bloink-build-%s-%s", r->pkg.name, r->pkg.version);
    char src_dir[BLOINK_MAX_PATH];
    snprintf(src_dir, sizeof(src_dir), "%s/src", work_dir);
    mkdir_p(src_dir);

    if (r->pkg.n_sources > 0) {
        if (fetch_sources(&r->pkg, cache_root, src_dir) != 0)
            return -1;
    }

    /* staging output dir, moved into the store atomically at the end */
    char stage_dir[BLOINK_MAX_PATH];
    snprintf(stage_dir, sizeof(stage_dir), "%s.stage", r->store_path);
    mkdir_p(stage_dir);

    /* run each step through a persistent shell so `cd` etc. carries
     * across lines, with $out/$src/dep vars exported */
    char script_path[BLOINK_MAX_PATH];
    snprintf(script_path, sizeof(script_path), "%s/build.sh", work_dir);
    FILE *sf = fopen(script_path, "w");
    if (!sf) return -1;
    fprintf(sf, "#!/bin/sh\nset -e\n");
    fprintf(sf, "export out='%s'\n", stage_dir);
    fprintf(sf, "export src='%s'\n", src_dir);
    fprintf(sf, "cd '%s'\n", src_dir);
    for (int i = 0; i < r->n_deps; ++i) {
        char envname[160];
        snprintf(envname, sizeof(envname), "BLOINK_DEP_%s", r->deps[i]->pkg.name);
        for (char *p = envname; *p; ++p) if (*p == '-') *p = '_'; else *p = (char)((*p>='a'&&*p<='z')?*p-32:*p);
        fprintf(sf, "export %s='%s'\n", envname, r->deps[i]->store_path);
        fprintf(sf, "export PATH=\"%s/bin:$PATH\"\n", r->deps[i]->store_path);
        fprintf(sf, "export PKG_CONFIG_PATH=\"%s/lib/pkgconfig:$PKG_CONFIG_PATH\"\n", r->deps[i]->store_path);
        fprintf(sf, "export CPATH=\"%s/include:$CPATH\"\n", r->deps[i]->store_path);
        fprintf(sf, "export LIBRARY_PATH=\"%s/lib:$LIBRARY_PATH\"\n", r->deps[i]->store_path);
    }
    for (int i = 0; i < r->pkg.n_steps; ++i)
        fprintf(sf, "%s\n", r->pkg.steps[i]);
    fclose(sf);

    char cmd[BLOINK_MAX_PATH + 16];
    snprintf(cmd, sizeof(cmd), "sh '%s'", script_path);
    if (run_cmd(cmd) != 0) {
        fprintf(stderr, "bloink: build failed for %s-%s (workdir kept at %s)\n",
                r->pkg.name, r->pkg.version, work_dir);
        return -1;
    }

    mkdir_p(store_root);
    if (rename(stage_dir, r->store_path) != 0) {
        char mvcmd[BLOINK_MAX_PATH * 2];
        snprintf(mvcmd, sizeof(mvcmd), "mv '%s' '%s'", stage_dir, r->store_path);
        if (run_cmd(mvcmd) != 0) {
            fprintf(stderr, "bloink: failed to install into store\n");
            return -1;
        }
    }

    char rmcmd[BLOINK_MAX_PATH + 16];
    snprintf(rmcmd, sizeof(rmcmd), "rm -rf '%s'", work_dir);
    system(rmcmd);

    fprintf(stderr, "bloink: %s-%s -> %s\n", r->pkg.name, r->pkg.version, r->store_path);
    r->built = 1;
    return 0;
}
