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
