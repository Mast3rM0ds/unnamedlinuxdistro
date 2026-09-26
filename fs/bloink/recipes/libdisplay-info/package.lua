return {
  name = "libdisplay-info",
  version = "0.2.0",
  description = "EDID and DisplayID parsing library (wlroots dependency)",
  license = "MIT",
  homepage = "https://gitlab.freedesktop.org/emersion/libdisplay-info",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/emersion/libdisplay-info/-/archive/0.2.0/libdisplay-info-0.2.0.tar.gz",
      sha256 = "f7331fcaf5527251b84c8fb84238d06cd2f458422ce950c80e86c72927aa8c2b",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
