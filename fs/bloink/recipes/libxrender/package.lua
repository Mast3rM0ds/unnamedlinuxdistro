return {
  name = "libxrender",
  version = "0.9.11",
  description = "X Rendering Extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXrender-0.9.11.tar.gz",
      sha256 = "6aec3ca02e4273a8cbabf811ff22106f641438eb194a12c0ae93c7e08474b667",
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
