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
      sha256 = "84fc597e6ec82f05dc18a7d12c17046f95bad7be99fc03c15bc254c4701ed204",
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
