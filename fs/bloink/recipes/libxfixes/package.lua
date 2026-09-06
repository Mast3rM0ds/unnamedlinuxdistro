return {
  name = "libxfixes",
  version = "6.0.1",
  description = "X Fixes extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXfixes-6.0.1.tar.gz",
      sha256 = "e69eaa321173c748ba6e2f15c7cf8da87f911d3ea1b6af4b547974aef6366bec",
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
