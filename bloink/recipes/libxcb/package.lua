return {
  name = "libxcb",
  version = "1.17.0",
  description = "X11 protocol client library (replaces Xlib's core transport)",
  license = "MIT",
  homepage = "https://xcb.freedesktop.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz",
      sha256 = "599ebf9996710fea71622e6e184f3a8ad5b43d0e5fa8c4e407123c88a59a6d55",
    },
  },

  deps = {
    { name = "libxau" },
    { name = "libxdmcp" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
