-- recipes/kwayland/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "kwayland",
  version = "6.3.0",
  description = "Qt/KDE wrapper around wayland-client and Wayland protocols",
  license = "LGPL-2.1-or-later",
  homepage = "https://invent.kde.org/frameworks/kwayland",

  sources = {
    {
      url = "https://download.kde.org/stable/frameworks/6.3/kwayland-6.3.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "extra-cmake-modules" },
    { name = "qtbase6" },
    { name = "qtwayland6" },
    { name = "wayland" },
    { name = "plasma-wayland-protocols" },
  },

  build = {
    "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release",
    "cmake --build build -j$(nproc)",
    "cmake --install build",
  },
}
