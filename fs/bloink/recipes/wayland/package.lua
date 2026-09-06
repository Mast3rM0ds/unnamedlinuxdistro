return {
  name = "wayland",
  version = "1.23.0",
  description = "Core Wayland protocol C library and scanner",
  license = "MIT",
  homepage = "https://wayland.freedesktop.org",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.23.0/downloads/wayland-1.23.0.tar.xz",
      sha256 = "05b3e1574d3e67626b5974f862f36b5b427c7ceeb965cb36a4e6c2d342e45ab2",
    },
  },

  deps = {
    { name = "libffi" },
    { name = "expat", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Ddocumentation=false -Dtests=false",
    "ninja -C build install",
  },
}
