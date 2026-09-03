-- recipes/harfbuzz/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "harfbuzz",
  version = "8.5.0",
  description = "OpenType text shaping engine",
  license = "MIT",
  homepage = "https://harfbuzz.github.io",

  sources = {
    {
      url = "https://github.com/harfbuzz/harfbuzz/releases/download/8.5.0/harfbuzz-8.5.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "freetype" },
    { name = "glib" },
  },

  build = {
    "meson setup build --prefix=$out -Dfreetype=enabled -Dglib=enabled",
    "ninja -C build install",
  },
}
