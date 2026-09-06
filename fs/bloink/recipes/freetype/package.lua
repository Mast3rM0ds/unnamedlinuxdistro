return {
  name = "freetype",
  version = "2.13.2",
  description = "Font rendering engine (built without harfbuzz to break the freetype<->harfbuzz cycle)",
  license = "FTL",
  homepage = "https://freetype.org",

  sources = {
    {
      url = "https://sourcebloink.net/projects/freetype/files/freetype2/2.13.2/freetype-2.13.2.tar.xz/download",
      sha256 = "PIN_ME"
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
