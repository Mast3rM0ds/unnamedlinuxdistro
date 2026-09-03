-- recipes/libxcb/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxcb",
  version = "1.17.0",
  description = "X11 protocol client library (replaces Xlib's core transport)",
  license = "MIT",
  homepage = "https://xcb.freedesktop.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "libxau" },
    { name = "libxdmcp" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
