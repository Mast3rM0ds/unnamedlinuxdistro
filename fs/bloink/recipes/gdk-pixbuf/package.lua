return {
  name = "gdk-pixbuf",
  version = "2.42.12",
  description = "Image loading library for GTK",
  license = "LGPL-2.1-or-later",
  homepage = "https://gitlab.gnome.org/GNOME/gdk-pixbuf",

  sources = {
    {
      url = "https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.12.tar.xz",
      sha256 = "b9505b3445b9a7e48ced34760c3bcb73e966df3ac94c95a148cb669ab748e3c7",
    },
  },

  deps = {
    { name = "glib" },
    { name = "pkgconf", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dman=false -Dgio_sniffing=false",
    "ninja -C build install",
  },
}
