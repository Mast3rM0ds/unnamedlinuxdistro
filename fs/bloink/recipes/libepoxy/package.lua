return {
  name = "libepoxy",
  version = "1.5.10",
  description = "GL/GLES/EGL/GLX function pointer dispatch library",
  license = "MIT",
  homepage = "https://github.com/anholt/libepoxy",

  sources = {
    {
      url = "https://github.com/anholt/libepoxy/releases/download/1.5.10/libepoxy-1.5.10.tar.xz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "libx11" },
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
