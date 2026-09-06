return {
  name = "json-glib",
  version = "1.8.0",
  description = "JSON parser/generator built on GLib types",
  license = "LGPL-2.1-or-later",
  homepage = "https://gitlab.gnome.org/GNOME/json-glib",

  sources = {
    {
      url = "https://download.gnome.org/sources/json-glib/1.8/json-glib-1.8.0.tar.xz",
      sha256 = "97ef5eb92ca811039ad50a65f06633f1aae64792789307be7170795d8b319454",
    },
  },

  deps = {
    { name = "glib" },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
