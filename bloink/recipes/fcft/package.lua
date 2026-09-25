return {
  name = "fcft",
  version = "3.2.2",
  description = "Font loading and glyph rasterization library, by the foot author",
  license = "MIT",
  homepage = "https://codeberg.org/dnkl/fcft",

  sources = {
    {
      url = "https://codeberg.org/dnkl/fcft/archive/3.2.2.tar.gz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "freetype" },
    { name = "fontconfig" },
    { name = "pixman" },
    { name = "harfbuzz" },
    { name = "tllist", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dgrapheme-shaping=disabled",
    "ninja -C build install",
  },
}
