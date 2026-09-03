/* store.c — content-addressed store paths, Nix-style but without the
 * mandatory purity ceremony: the hash covers the recipe file's own
 * content plus the resolved store paths of its dependencies, which is
 * enough to make paths change whenever anything that could affect the
 * build output changes, without forcing hermetic sandboxing on anyone
 * who doesn't want it (see docs/PHILOSOPHY.md).
 */
#include "bloink.h"
#include "sha256.h"
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

int bloink_store_path(const BloinkPackage *pkg, const char *deps_hash, const char *store_root, char *out, size_t outlen) {
    FILE *f = fopen(pkg->recipe_path, "rb");
    if (!f) return -1;
    char buf[65536];
    size_t n = fread(buf, 1, sizeof(buf) - 1, f);
    fclose(f);
    buf[n] = 0;

    const char *parts[3];
    parts[0] = buf;
    parts[1] = deps_hash ? deps_hash : "";
    parts[2] = pkg->version;

    char hash[65];
    sha256_hex_multi(parts, 3, hash);

    /* short, Nix-flavored hash prefix keeps paths readable */
    char short_hash[13];
    memcpy(short_hash, hash, 12);
    short_hash[12] = 0;

    snprintf(out, outlen, "%s/%s-%s-%s", store_root ? store_root : BLOINK_STORE_DEFAULT,
              short_hash, pkg->name, pkg->version);
    return 0;
}

int bloink_store_exists(const char *store_path) {
    struct stat st;
    return stat(store_path, &st) == 0 && S_ISDIR(st.st_mode);
}
