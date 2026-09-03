-- recipes/plasma-wayland-protocols/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "plasma-wayland-protocols",
  version = "1.14.0",
  description = "KDE Plasma's Wayland protocol XML extensions",
  license = "BSD-3-Clause",
  homepage = "https://invent.kde.org/libraries/plasma-wayland-protocols",

  sources = {
    {
      url = "https://download.kde.org/stable/plasma/wayland-protocols/plasma-wayland-protocols-1.14.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
  },

  build = {
    "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release",
    "cmake --build build -j$(nproc)",
    "cmake --install build",
  },
}
