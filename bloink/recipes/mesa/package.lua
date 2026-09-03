-- recipes/mesa/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "mesa",
  version = "24.1.0",
  description = "OpenGL/Vulkan/EGL implementation (GPU drivers)",
  license = "MIT",
  homepage = "https://mesa3d.org",

  sources = {
    {
      url = "https://archive.mesa3d.org/mesa-24.1.0.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "libdrm" },
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "libxkbcommon" },
    { name = "zlib" },
    { name = "libx11" },
    { name = "libxcb" },
    { name = "expat" },
  },

  build = {
    "meson setup build --prefix=$out -Dplatforms=x11,wayland -Dgallium-drivers=swrast,zink -Dvulkan-drivers=",
    "ninja -C build install",
  },
}
