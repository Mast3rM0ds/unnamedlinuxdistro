return {
  name = "libxext",
  version = "1.3.6",
  description = "Common X11 protocol extensions library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXext-1.3.6.tar.gz",
      sha256 = "1a0ac5cd792a55d5d465ced8dbf403ed016c8e6d14380c0ea3646c4415496e3d",
    },
  },

  deps = {
    { name = "libx11" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
