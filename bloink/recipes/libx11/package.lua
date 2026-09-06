return {
  name = "libx11",
  version = "1.8.9",
  description = "Core X11 client library (Xlib)",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libX11-1.8.9.tar.xz",
      sha256 = "779d8f111d144ef93e2daa5f23a762ce9555affc99592844e71c4243d3bd3262",
    },
  },

  deps = {
    { name = "libxcb" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
