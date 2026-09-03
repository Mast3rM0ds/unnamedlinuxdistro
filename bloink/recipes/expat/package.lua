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
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
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
