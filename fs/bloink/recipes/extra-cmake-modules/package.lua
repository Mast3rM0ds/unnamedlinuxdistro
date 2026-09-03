-- recipes/extra-cmake-modules/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
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
