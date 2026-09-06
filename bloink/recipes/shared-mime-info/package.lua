return {
  name = "shared-mime-info",
  version = "2.4",
  description = "Freedesktop shared MIME-type database",
  license = "GPL-2.0-or-later/AFL",
  homepage = "https://gitlab.freedesktop.org/xdg/shared-mime-info",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.4/shared-mime-info-2.4.tar.gz",
      sha256 = "531291d0387eb94e16e775d7e73788d06d2b2fdd8cd2ac6b6b15287593b6a2de",
    },
  },

  deps = {
    { name = "glib" },
    { name = "libxml2", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
