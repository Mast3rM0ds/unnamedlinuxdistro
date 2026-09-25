return {
  name = "mtdev",
  version = "1.1.7",
  description = "Multitouch protocol translation library (libinput build dependency)",
  license = "MIT",
  homepage = "https://www.freedesktop.org/wiki/Software/mtdev/",

  sources = {
    {
      url = "https://bitmath.org/code/mtdev/mtdev-1.1.7.tar.bz2",
      sha256 = "PIN_ME"
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
