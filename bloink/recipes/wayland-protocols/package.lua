-- recipes/wayland-protocols/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "wayland-protocols",
  version = "1.36",
  description = "Additional Wayland protocol XML definitions",
  license = "MIT",
  homepage = "https://wayland.freedesktop.org",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.36/downloads/wayland-protocols-1.36.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "wayland", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dtests=false",
    "ninja -C build install",
  },
}
