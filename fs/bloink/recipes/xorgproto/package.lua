return {
  name = "xorgproto",
  version = "2024.1",
  description = "X11 protocol headers (no library, headers only)",
  license = "MIT",
  homepage = "https://gitlab.freedesktop.org/xorg/proto/xorgproto",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz",
      sha256 = "372225fd40815b8423547f5d890c5debc72e88b91088fbfb13158c20495ccb59",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
