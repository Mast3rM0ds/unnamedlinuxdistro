-- recipes/libxtst/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxtst",
  version = "1.2.4",
  description = "X Test extension client library (input synthesis)",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXtst-1.2.4.tar.gz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxext" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
