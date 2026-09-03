-- recipes/libepoxy/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libepoxy",
  version = "1.5.10",
  description = "GL/GLES/EGL/GLX function pointer dispatch library",
  license = "MIT",
  homepage = "https://github.com/anholt/libepoxy",

  sources = {
    {
      url = "https://github.com/anholt/libepoxy/releases/download/1.5.10/libepoxy-1.5.10.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "libx11" },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
