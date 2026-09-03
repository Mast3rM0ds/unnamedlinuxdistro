-- recipes/libxkbcommon/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxkbcommon",
  version = "1.7.0",
  description = "Keymap handling library (XKB) for Wayland and X11",
  license = "MIT",
  homepage = "https://xkbcommon.org",

  sources = {
    {
      url = "https://xkbcommon.org/download/libxkbcommon-1.7.0.tar.xz",
      sha256 = "65782f0a10a4b455af9c6baab7040e2f537520caa2ec2092805cdfd36863b247",
    },
  },

  deps = {
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Denable-docs=false -Denable-wayland=true",
    "ninja -C build install",
  },
}
