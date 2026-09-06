return {
  name = "libxcursor",
  version = "1.2.2",
  description = "X cursor management library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXcursor-1.2.2.tar.gz",
      sha256 = "98c3a30a3f85274c167d1ac5419d681ce41f14e27bfa5fe3003c8172cd8af104",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxrender" },
    { name = "libxfixes" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
