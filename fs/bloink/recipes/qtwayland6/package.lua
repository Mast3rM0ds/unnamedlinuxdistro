return {
  name = "qtwayland6",
  version = "6.7.2",
  description = "Qt6 Wayland platform plugin and compositor API",
  license = "LGPL-3.0-only OR GPL-2.0-only",
  homepage = "https://www.qt.io",

  sources = {
    {
      url = "https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtwayland-everywhere-src-6.7.2.tar.xz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "qtbase6" },
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "libxkbcommon" },
  },

  build = {
    "cmake -B build -GNinja -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release -DQt6_DIR=$BLOINK_DEP_QTBASE6/lib/cmake/Qt6",
    "cmake --build build -j$(nproc)",
    "cmake --install build",
  },
}
