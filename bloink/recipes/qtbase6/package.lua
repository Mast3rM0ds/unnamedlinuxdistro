return {
  name = "qtbase6",
  version = "6.7.2",
  description = "Qt6 core, GUI, and platform-integration modules",
  license = "LGPL-3.0-only OR GPL-2.0-only",
  homepage = "https://www.qt.io",

  sources = {
    {
      url = "https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtbase-everywhere-src-6.7.2.tar.xz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "mesa" },
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "libxkbcommon" },
    { name = "libx11" },
    { name = "libxcb" },
    { name = "libxext" },
    { name = "libxrandr" },
    { name = "libxi" },
    { name = "libxrender" },
    { name = "libxfixes" },
    { name = "fontconfig" },
    { name = "freetype" },
    { name = "zlib" },
    { name = "dbus" },
  },

  build = {
    "cmake -B build -GNinja -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release -DFEATURE_dbus=ON -DFEATURE_xcb=ON",
    "cmake --build build -j$(nproc)",
    "cmake --install build",
  },
}
