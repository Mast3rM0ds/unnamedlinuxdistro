-- recipes/pango/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "pango",
  version = "1.54.0",
  description = "Text layout and internationalization engine",
  license = "LGPL-2.1-or-later",
  homepage = "https://pango.gnome.org",

  sources = {
    {
      url = "https://download.gnome.org/sources/pango/1.54/pango-1.54.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
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
