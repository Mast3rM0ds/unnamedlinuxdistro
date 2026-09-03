-- recipes/libxinerama/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxinerama",
  version = "1.1.5",
  description = "Xinerama multi-monitor extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXinerama-1.1.5.tar.gz",
      sha256 = "2efa855cb42dc620eff3b77700d8655695e09aaa318f791f201fa60afa72b95c",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxext" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
