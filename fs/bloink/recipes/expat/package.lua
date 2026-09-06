return {
  name = "expat",
  version = "2.6.2",
  description = "Stream-oriented XML parser",
  license = "MIT",
  homepage = "https://libexpat.github.io/",

  sources = {
    {
      url = "https://github.com/libexpat/libexpat/releases/download/R_2_6_2/expat-2.6.2.tar.xz",
      sha256 = "ee14b4c5d8908b1bec37ad937607eab183d4d9806a08adee472c3c3121d27364",
    },
  },

  deps = {
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
