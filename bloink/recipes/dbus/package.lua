-- recipes/dbus/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "dbus",
  version = "1.15.8",
  description = "Message bus for inter-process/session communication",
  license = "GPL-2.0-or-later/AFL-2.1",
  homepage = "https://dbus.freedesktop.org",

  sources = {
    {
      url = "https://dbus.freedesktop.org/releases/dbus/dbus-1.15.8.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "expat" },
  },

  build = {
    "meson setup build --prefix=$out -Dsystemd=disabled -Dlaunchd=disabled",
    "ninja -C build install",
  },
}
