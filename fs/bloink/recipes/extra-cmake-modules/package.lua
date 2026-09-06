return {
  name = "extra-cmake-modules",
  version = "6.3.0",
  description = "Shared CMake modules used across KDE Frameworks",
  license = "BSD-3-Clause",
  homepage = "https://api.kde.org/ecm/",

  sources = {
    {
      url = "https://download.kde.org/stable/frameworks/6.3/extra-cmake-modules-6.3.0.tar.xz",
      sha256 = "1368f8fba95c475a409eff05f78baf49ccd2655889d1e94902bfc886785af818",
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
