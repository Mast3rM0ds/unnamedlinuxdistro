-- recipes/fontconfig/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "fontconfig",
  version = "2.15.0",
  description = "Font matching and configuration library",
  license = "MIT-like",
  homepage = "https://fontconfig.org",

  sources = {
    {
      url = "https://fontconfig.org/release/fontconfig-2.15.0.tar.xz",
      sha256 = "63a0658d0e06e0fa886106452b58ef04f21f58202ea02a94c39de0d3335d7c0e",
    },
  },

  deps = {
    { name = "freetype" },
    { name = "expat" },
    { name = "zlib" },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
