-- recipes/libxrandr/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxrandr",
  version = "1.5.4",
  description = "X Resize, Rotate and Reflect extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXrandr-1.5.4.tar.gz",
      sha256 = "c72c94dc3373512ceb67f578952c5d10915b38cc9ebb0fd176a49857b8048e22",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxext" },
    { name = "libxrender" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
