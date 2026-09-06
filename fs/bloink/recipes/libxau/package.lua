return {
  name = "libxau",
  version = "1.0.11",
  description = "X11 authorization library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXau-1.0.11.tar.xz",
      sha256 = "f3fa3282f5570c3f6bd620244438dbfbdd580fc80f02f549587a0f8ab329bbeb",
    },
  },

  deps = {
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
