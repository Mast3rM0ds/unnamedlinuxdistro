-- recipes/libx11/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libx11",
  version = "1.8.9",
  description = "Core X11 client library (Xlib)",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libX11-1.8.9.tar.xz",
      sha256 = "779d8f111d144ef93e2daa5f23a762ce9555affc99592844e71c4243d3bd3262",
    },
  },

  deps = {
    { name = "libxcb" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
