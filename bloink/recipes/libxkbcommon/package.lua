return {
  name = "libxkbcommon",
  version = "1.7.0",
  description = "Keymap handling library (XKB) for Wayland and X11",
  license = "MIT",
  homepage = "https://xkbcommon.org",

  sources = {
    {
      url = "https://xkbcommon.org/download/libxkbcommon-1.7.0.tar.xz",
      sha256 = "65782f0a10a4b455af9c6baab7040e2f537520caa2ec2092805cdfd36863b247",
    },
  },

  deps = {
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Denable-docs=false -Denable-wayland=true",
    "ninja -C build install",
  },
}
