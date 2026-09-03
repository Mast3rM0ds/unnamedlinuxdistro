# bloink

A small, musl-first package manager. Recipes are real Lua. The tool
itself is a static ~350KB binary with no daemon and no init dependency.
See `docs/PHILOSOPHY.md` for why it's built this way, point by point.

## Build

Needs `gcc`/`musl-gcc`, `musl-dev`, and Lua 5.4 headers to build bloink
itself (the Lua *interpreter* is vendored and statically linked into
the resulting binary — end users of `bloink` need nothing extra).

```sh
# one-time: fetch and build vendored Lua as a static musl lib
cd vendor/lua && musl-gcc -Os -std=c99 -DLUA_USE_POSIX \
  -c $(ls l*.c | grep -v -e '^lua.c$' -e '^luac.c$') && \
  ar rcs ../liblua.a *.o && cd -

# build bloink
musl-gcc -Os -static -std=c11 -Ivendor/include \
  src/main.c src/lua_recipe.c src/resolve.c src/store.c \
  src/build.c src/profile.c src/sha256.c \
  vendor/liblua.a -lm -o bloink
```

`file bloink` should report a statically linked ELF binary with no
dynamic dependencies.

## Use

```sh
export BLOINK_RECIPES=$PWD/recipes
export BLOINK_STORE=/bloink/store          # or anywhere you like
export BLOINK_PROFILES=/bloink/profiles
export BLOINK_CACHE=/bloink/cache

bloink list                 # every recipe available
bloink show wayland         # resolved metadata + dependency closure
bloink build zlib           # build a package and its dependency closure
bloink install zlib         # build + symlink into a profile
```

`zlib` is the one recipe in this tree with a **real, verified**
sha256 pin, so it's a working example end to end: `bloink install zlib`
actually fetches, verifies, compiles, and installs it.

Every other recipe under `recipes/` has a real dependency graph and
real build steps but a `PIN_ME` placeholder instead of a sha256,
because this environment can't reach the hosts they live on. Run:

```sh
tools/bloink-pin recipes/wayland/package.lua
tools/bloink-pin recipes/*/package.lua       # or all of them
```

from a machine with normal internet access to fill those in — bloink
deliberately refuses to fetch anything unpinned.

## Writing a new recipe

```lua
-- recipes/mylib/package.lua
return {
  name = "mylib",
  version = "1.0.0",
  description = "...",
  license = "MIT",
  homepage = "https://example.org",

  sources = {
    { url = "https://example.org/mylib-1.0.0.tar.gz",
      sha256 = "..." },   -- required; bloink refuses unverified fetches
  },

  deps = {
    { name = "zlib" },
    { name = "pkgconf", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
```

`$out`, `$src`, and `BLOINK_DEP_<NAME>` (plus `PATH`/`PKG_CONFIG_PATH`/
`CPATH`/`LIBRARY_PATH` pointed at each dependency) are exported for
every build step. It's just a shell script bloink assembles and runs
with `sh`.

## Layout

```
src/            bloink itself (C, statically linked against musl)
vendor/         vendored Lua 5.4 source + built static lib
recipes/        52 starter recipes for the X11/Wayland/desktop stack
tools/bloink-pin fills in sha256 pins from a machine with real internet
docs/           design rationale
```
