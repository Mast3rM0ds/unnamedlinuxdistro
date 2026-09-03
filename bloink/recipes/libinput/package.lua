-- recipes/libinput/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libinput",
  version = "1.26.1",
  description = "Input device handling library used by Wayland compositors",
  license = "MIT",
  homepage = "https://www.freedesktop.org/wiki/Software/libinput/",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.26.1/libinput-1.26.1.tar.gz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "seatd" },
    { name = "libxkbcommon" },
    { name = "mtdev", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dudev=disabled -Ddebug-gui=false -Dtests=false -Dlibwacom=false",
    "ninja -C build install",
  },
}
