return {
  name = "libdrm",
  version = "2.4.122",
  description = "Userspace interface to kernel DRM (GPU) subsystem",
  license = "MIT",
  homepage = "https://dri.freedesktop.org",

  sources = {
    {
      url = "https://dri.freedesktop.org/libdrm/libdrm-2.4.122.tar.xz",
      sha256 = "d9f5079b777dffca9300ccc56b10a93588cdfbc9dde2fae111940dfb6292f251",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
