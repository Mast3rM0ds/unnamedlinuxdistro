return {
  name = "libxinerama",
  version = "1.1.5",
  description = "Xinerama multi-monitor extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXinerama-1.1.5.tar.gz",
      sha256 = "2efa855cb42dc620eff3b77700d8655695e09aaa318f791f201fa60afa72b95c",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxext" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
