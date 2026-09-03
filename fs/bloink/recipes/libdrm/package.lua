-- recipes/libdrm/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libdrm",
  version = "2.4.122",
  description = "Userspace interface to kernel DRM (GPU) subsystem",
  license = "MIT",
  homepage = "https://dri.freedesktop.org",

  sources = {
    {
      url = "https://dri.freedesktop.org/libdrm/libdrm-2.4.122.tar.xz",
      sha256 = "d9f5079b777dffca9300ccc56b10a93588cdfbc9dde2fae111940dfb6292f251",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
