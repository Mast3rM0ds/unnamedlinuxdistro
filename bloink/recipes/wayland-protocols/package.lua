return {
  name = "wayland-protocols",
  version = "1.36",
  description = "Additional Wayland protocol XML definitions",
  license = "MIT",
  homepage = "https://wayland.freedesktop.org",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.36/downloads/wayland-protocols-1.36.tar.xz",
      sha256 = "71fd4de05e79f9a1ca559fac30c1f8365fa10346422f9fe795f74d77b9ef7e92",
    },
  },

  deps = {
    { name = "wayland", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dtests=false",
    "ninja -C build install",
  },
}
