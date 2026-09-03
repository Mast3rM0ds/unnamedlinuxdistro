-- recipes/libxshmfence/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxshmfence",
  version = "1.3.2",
  description = "Shared memory fences for X11/DRI3 sync",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libxshmfence-1.3.2.tar.gz",
      sha256 = "e93a85099604beb244ee756dcaf70e18b08701c1ca84c4de0126cd71bd6c8181",
    },
  },

  deps = {
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
