# Installing bloink into unnamedlinuxdistro

## 1. Rebuild on your own machine

Don't ship the binary from wherever you generated these files — recompile
it with your own toolchain so you know exactly what libc and musl version
it's linked against:

```sh
cd bloink

# rebuild vendored Lua as a static musl lib
cd vendor/lua && musl-gcc -Os -std=c99 -DLUA_USE_POSIX \
  -c $(ls l*.c | grep -v -e '^lua.c$' -e '^luac.c$') && \
  ar rcs ../liblua.a *.o && rm -f *.o && cd -

# rebuild bloink itself
musl-gcc -Os -static -std=c11 -Ivendor/include \
  src/main.c src/lua_recipe.c src/resolve.c src/store.c \
  src/build.c src/profile.c src/sha256.c \
  vendor/liblua.a -lm -o bloink

file bloink   # confirm: statically linked, no dynamic deps
```

If `musl-gcc` isn't on your build host, install `musl-tools`/`musl-dev`
(or whatever your distro's build tooling calls it) first.

## 2. Copy into the filesystem tree

Your repo is `~/Work/unnamedlinuxdistro`, filesystem staging is `fs/`. Lay
it out the same way it'll exist on a booted system:

```sh
cd ~/Work/unnamedlinuxdistro

install -Dm755 /path/to/bloink/bloink            fs/usr/bin/bloink
cp -r          /path/to/bloink/recipes           fs/var/lib/bloink/recipes
install -Dm755 /path/to/bloink/tools/bloink-pin  fs/usr/bin/bloink-pin

mkdir -p fs/var/lib/bloink/store \
         fs/var/lib/bloink/profiles \
         fs/var/lib/bloink/cache
```

`/usr/bin` for the binary and helper script (on $PATH by default),
`/var/lib/bloink` for everything mutable (store/profiles/cache/recipes) —
matches where most distros put package-manager state (compare
`/var/lib/dpkg`, `/var/lib/pacman`).

## 3. Point bloink at that layout by default

Right now bloink's built-in defaults are `/bloink/store` etc (see
`src/bloink.h`). Either:

- **(a)** repoint the defaults to `/var/lib/bloink/...` and rebuild, or
- **(b)** set env vars system-wide, e.g. drop a file at
  `fs/etc/profile.d/bloink.sh`:

```sh
export BLOINK_RECIPES=/var/lib/bloink/recipes
export BLOINK_STORE=/var/lib/bloink/store
export BLOINK_PROFILES=/var/lib/bloink/profiles
export BLOINK_CACHE=/var/lib/bloink/cache
export PATH="/var/lib/bloink/profiles/default/bin:$PATH"
```

(a) is cleaner for a distro-shipped binary since it works even before
`/etc/profile.d` has run (early boot scripts, non-login shells); (b) is
easier to tweak without recompiling. Pick one — this is exactly the kind
of default bloink deliberately doesn't hardcode for you.

## 4. Pin real hashes before anyone builds from these recipes

51 of the 52 recipes still have `sha256 = "PIN_ME"`. From a machine with
working internet (yours, now that wget + `--no-check-certificate` gets
you past the missing ca-certificates issue):

```sh
tools/bloink-pin              # pins every unpinned recipe under recipes/
```

Do this and commit the result *before* baking recipes into an image —
bloink refuses to fetch anything unpinned on purpose, so an unpinned
recipe just fails loudly rather than building.

## 5. Smoke-test

```sh
export BLOINK_RECIPES=~/Work/unnamedlinuxdistro/fs/var/lib/bloink/recipes
export BLOINK_STORE=~/Work/unnamedlinuxdistro/fs/var/lib/bloink/store
export BLOINK_PROFILES=~/Work/unnamedlinuxdistro/fs/var/lib/bloink/profiles
export BLOINK_CACHE=~/Work/unnamedlinuxdistro/fs/var/lib/bloink/cache

bloink install zlib   # the one recipe with a real pin already
```

If that installs and `fs/var/lib/bloink/profiles/default/bin` etc show
up populated, the layout's correct and you're ready to pin + build the
rest of the stack.

## About ca-certificates

`--no-check-certificate` on wget skips TLS certificate validation — the
actual trust boundary is the sha256 pin bloink checks after every fetch,
not the handshake. If you'd rather have real cert validation (and you
generally should, once the base system has a CA bundle), build/install
`ca-certificates` as an early bootstrap package and drop the flag from
`src/build.c`'s `fetch_sources()` and `tools/bloink-pin`.
