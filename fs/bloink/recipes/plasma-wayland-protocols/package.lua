return {
  name = "plasma-wayland-protocols",
  version = "1.14.0",
  description = "KDE Plasma's Wayland protocol XML extensions",
  license = "BSD-3-Clause",
  homepage = "https://invent.kde.org/libraries/plasma-wayland-protocols",

  sources = {
    {
      url = "https://download.kde.org/stable/plasma/wayland-protocols/plasma-wayland-protocols-1.14.0.tar.xz",
      sha256 = "PIN_ME"
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
