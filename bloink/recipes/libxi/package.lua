return {
  name = "libxi",
  version = "1.8.1",
  description = "X Input extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXi-1.8.1.tar.gz",
      sha256 = "3b5f47c223e4b63d7f7fe758886b8bf665b20a7edb6962c423892fd150e326ea",
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
