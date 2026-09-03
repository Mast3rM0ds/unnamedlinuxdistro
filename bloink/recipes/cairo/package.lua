-- recipes/cairo/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "cairo",
  version = "1.18.0",
  description = "2D vector graphics library",
  license = "LGPL-2.1-or-later OR MPL-1.1",
  homepage = "https://cairographics.org",

  sources = {
    {
      url = "https://cairographics.org/releases/cairo-1.18.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "pixman" },
    { name = "freetype" },
    { name = "fontconfig" },
    { name = "libx11" },
    { name = "libxext" },
    { name = "libxrender" },
  },

  build = {
    "meson setup build --prefix=$out -Dtests=disabled",
    "ninja -C build install",
  },
}
