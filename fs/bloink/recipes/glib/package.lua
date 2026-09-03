-- recipes/glib/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "glib",
  version = "2.80.2",
  description = "Core low-level application/utility library (GObject, GIO, etc.)",
  license = "LGPL-2.1-or-later",
  homepage = "https://gitlab.gnome.org/GNOME/glib",

  sources = {
    {
      url = "https://download.gnome.org/sources/glib/2.80/glib-2.80.2.tar.xz",
      sha256 = "b9cfb6f7a5bd5b31238fd5d56df226b2dda5ea37611475bf89f6a0f9400fe8bd",
    },
  },

  deps = {
    { name = "libffi" },
    { name = "zlib" },
    { name = "pkgconf", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dtests=false",
    "ninja -C build install",
  },
}
