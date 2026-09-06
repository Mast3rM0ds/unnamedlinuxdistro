return {
  name = "libxtst",
  version = "1.2.4",
  description = "X Test extension client library (input synthesis)",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXtst-1.2.4.tar.gz",
      sha256 = "01366506aeb033f6dffca5326af85f670746b0cabbfd092aabefb046cf48c445",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxext" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
