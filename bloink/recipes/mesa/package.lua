return {
  name = "mesa",
  version = "24.1.0",
  description = "OpenGL/Vulkan/EGL implementation (GPU drivers)",
  license = "MIT",
  homepage = "https://mesa3d.org",

  sources = {
    {
      url = "https://archive.mesa3d.org/mesa-24.1.0.tar.xz",
      sha256 = "b7eac8c79244806b1c276eeeacc329e4a5b31a370804c4b0c7cd16837783f78b",
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
