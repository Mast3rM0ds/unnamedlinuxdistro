-- recipes/shared-mime-info/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "shared-mime-info",
  version = "2.4",
  description = "Freedesktop shared MIME-type database",
  license = "GPL-2.0-or-later/AFL",
  homepage = "https://gitlab.freedesktop.org/xdg/shared-mime-info",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.4/shared-mime-info-2.4.tar.gz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
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
