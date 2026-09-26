return {
  name = "tllist",
  version = "1.1.0",
  description = "Header-only typed linked list library (foot/fcft dependency)",
  license = "MIT",
  homepage = "https://codeberg.org/dnkl/tllist",

  sources = {
    {
      url = "https://codeberg.org/dnkl/tllist/archive/1.1.0.tar.gz",
      sha256 = "0e7b7094a02550dd80b7243bcffc3671550b0f1d8ba625e4dff52517827d5d23",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
