return {
  name = "fontconfig",
  version = "2.15.0",
  description = "Font matching and configuration library",
  license = "MIT-like",
  homepage = "https://fontconfig.org",

  sources = {
    {
      url = "https://fontconfig.org/release/fontconfig-2.15.0.tar.xz",
      sha256 = "63a0658d0e06e0fa886106452b58ef04f21f58202ea02a94c39de0d3335d7c0e",
    },
  },

  deps = {
    { name = "freetype" },
    { name = "expat" },
    { name = "zlib" },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
