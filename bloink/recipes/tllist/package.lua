return {
  name = "tllist",
  version = "1.1.0",
  description = "Header-only typed linked list library (foot/fcft dependency)",
  license = "MIT",
  homepage = "https://codeberg.org/dnkl/tllist",

  sources = {
    {
      url = "https://codeberg.org/dnkl/tllist/archive/1.1.0.tar.gz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
