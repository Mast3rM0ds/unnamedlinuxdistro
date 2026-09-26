return {
  name = "wlroots",
  version = "0.19.0",
  description = "Modular Wayland compositor library — pluggable backends (DRM/KMS, libinput) and protocol implementations that sway, tinywl, and most other wlroots-based compositors are built on. Ships tinywl as a bundled example.",
  license = "MIT",
  homepage = "https://gitlab.freedesktop.org/wlroots/wlroots",

  sources = {
    {
      url = "https://gitlab.freedesktop.org/wlroots/wlroots/-/releases/0.19.0/downloads/wlroots-0.19.0.tar.gz",
      sha256 = "aefb0fe2633b0aad1d66123b2f41afab004fb625e2a7790492cdd39a805cac91",
    },
  },

  deps = {
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "libxkbcommon" },
    { name = "pixman" },
    { name = "libdrm" },
    { name = "mesa" },
    { name = "libinput" },
    { name = "seatd" },
    { name = "libdisplay-info" },
  },

  build = {
    "meson setup build --prefix=$out -Dbackends=drm,libinput -Drenderers=gles2,pixman -Dallocators=gbm -Dsession=libseat -Dxwayland=disabled -Dx11-backend=disabled -Dexamples=true",
    "ninja -C build install",
  },
}
