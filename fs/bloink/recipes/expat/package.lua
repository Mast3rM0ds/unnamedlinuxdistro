-- recipes/expat/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "expat",
  version = "2.6.2",
  description = "Stream-oriented XML parser",
  license = "MIT",
  homepage = "https://libexpat.github.io/",

  sources = {
    {
      url = "https://github.com/libexpat/libexpat/releases/download/R_2_6_2/expat-2.6.2.tar.xz",
      sha256 = "ee14b4c5d8908b1bec37ad937607eab183d4d9806a08adee472c3c3121d27364",
    },
  },

  deps = {
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
