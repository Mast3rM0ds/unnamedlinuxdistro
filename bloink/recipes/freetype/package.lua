-- recipes/freetype/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "freetype",
  version = "2.13.2",
  description = "Font rendering engine (built without harfbuzz to break the freetype<->harfbuzz cycle)",
  license = "FTL",
  homepage = "https://freetype.org",

  sources = {
    {
      url = "https://sourcebloink.net/projects/freetype/files/freetype2/2.13.2/freetype-2.13.2.tar.xz/download",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "zlib" },
  },

  build = {
    "meson setup build --prefix=$out -Dharfbuzz=disabled -Dbrotli=disabled",
    "ninja -C build install",
  },
}
