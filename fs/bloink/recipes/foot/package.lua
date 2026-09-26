return {
  name = "foot",
  version = "1.19.1",
  description = "Fast, lightweight, native Wayland terminal emulator",
  license = "MIT",
  homepage = "https://codeberg.org/dnkl/foot",

  sources = {
    {
      url = "https://codeberg.org/dnkl/foot/archive/1.19.1.tar.gz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "libxkbcommon" },
    { name = "pixman" },
    { name = "fontconfig" },
    { name = "freetype" },
    { name = "fcft" },
    { name = "tllist" },
  },

  build = {
    "meson setup build --prefix=$out --buildtype=release -Db_lto=true",
    "ninja -C build install",
  },
}
