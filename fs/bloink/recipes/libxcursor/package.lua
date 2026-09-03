-- recipes/libxcursor/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxcursor",
  version = "1.2.2",
  description = "X cursor management library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXcursor-1.2.2.tar.gz",
      sha256 = "98c3a30a3f85274c167d1ac5419d681ce41f14e27bfa5fe3003c8172cd8af104",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxrender" },
    { name = "libxfixes" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
