return {
  name = "harfbuzz",
  version = "8.5.0",
  description = "OpenType text shaping engine",
  license = "MIT",
  homepage = "https://harfbuzz.github.io",

  sources = {
    {
      url = "https://github.com/harfbuzz/harfbuzz/releases/download/8.5.0/harfbuzz-8.5.0.tar.xz",
      sha256 = "77e4f7f98f3d86bf8788b53e6832fb96279956e1c3961988ea3d4b7ca41ddc27",
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
