return {
  name = "kwayland",
  version = "6.3.0",
  description = "Qt/KDE wrapper around wayland-client and Wayland protocols",
  license = "LGPL-2.1-or-later",
  homepage = "https://invent.kde.org/frameworks/kwayland",

  sources = {
    {
      url = "https://download.kde.org/stable/frameworks/6.3/kwayland-6.3.0.tar.xz",
      sha256 = "PIN_ME"
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
