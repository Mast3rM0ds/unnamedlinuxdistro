return {
  name = "at-spi2-core",
  version = "2.52.0",
  description = "Accessibility bus and core protocol (used by GTK)",
  license = "LGPL-2.1-or-later",
  homepage = "https://gitlab.gnome.org/GNOME/at-spi2-core",

  sources = {
    {
      url = "https://download.gnome.org/sources/at-spi2-core/2.52/at-spi2-core-2.52.0.tar.xz",
      sha256 = "0ac3fc8320c8d01fa147c272ba7fa03806389c6b03d3c406d0823e30e35ff5ab",
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
