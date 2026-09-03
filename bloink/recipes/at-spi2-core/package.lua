-- recipes/at-spi2-core/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "at-spi2-core",
  version = "2.52.0",
  description = "Accessibility bus and core protocol (used by GTK)",
  license = "LGPL-2.1-or-later",
  homepage = "https://gitlab.gnome.org/GNOME/at-spi2-core",

  sources = {
    {
      url = "https://download.gnome.org/sources/at-spi2-core/2.52/at-spi2-core-2.52.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "glib" },
    { name = "dbus" },
    { name = "libx11" },
    { name = "libxtst" },
    { name = "libxi" },
  },

  build = {
    "meson setup build --prefix=$out -Dx11=yes",
    "ninja -C build install",
  },
}
