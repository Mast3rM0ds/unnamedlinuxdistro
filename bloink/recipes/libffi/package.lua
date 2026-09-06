return {
  name = "libffi",
  version = "3.4.6",
  description = "Foreign function interface library",
  license = "MIT",
  homepage = "https://sourceware.org/libffi/",

  sources = {
    {
      url = "https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz",
      sha256 = "b0dea9df23c863a7a50e825440f3ebffabd65df1497108e5d437747843895a4e",
    },
  },

  deps = {
  },

  build = {
    "./configure --prefix=$out --disable-static",
    "make -j$(nproc)",
    "make install",
  },
}
