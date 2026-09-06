return {
  name = "libxdmcp",
  version = "1.1.5",
  description = "X Display Manager Control Protocol library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXdmcp-1.1.5.tar.xz",
      sha256 = "d8a5222828c3adab70adf69a5583f1d32eb5ece04304f7f8392b6a353aa2228c",
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
