return {
  name = "pango",
  version = "1.54.0",
  description = "Text layout and internationalization engine",
  license = "LGPL-2.1-or-later",
  homepage = "https://pango.gnome.org",

  sources = {
    {
      url = "https://download.gnome.org/sources/pango/1.54/pango-1.54.0.tar.xz",
      sha256 = "8a9eed75021ee734d7fc0fdf3a65c3bba51dfefe4ae51a9b414a60c70b2d1ed8",
    },
  },

  deps = {
    { name = "cairo" },
    { name = "harfbuzz" },
    { name = "freetype" },
    { name = "fontconfig" },
    { name = "glib" },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
