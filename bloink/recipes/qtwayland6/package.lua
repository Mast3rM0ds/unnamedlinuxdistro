-- recipes/qtwayland6/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "qtwayland6",
  version = "6.7.2",
  description = "Qt6 Wayland platform plugin and compositor API",
  license = "LGPL-3.0-only OR GPL-2.0-only",
  homepage = "https://www.qt.io",

  sources = {
    {
      url = "https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtwayland-everywhere-src-6.7.2.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
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
