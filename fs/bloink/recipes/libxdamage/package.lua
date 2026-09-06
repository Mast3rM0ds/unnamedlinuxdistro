return {
  name = "libxdamage",
  version = "1.1.6",
  description = "X Damage extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXdamage-1.1.6.tar.gz",
      sha256 = "2afcc139eb6eb926ffe344494b1fc023da25def42874496e6e6d3aa8acef8595",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
