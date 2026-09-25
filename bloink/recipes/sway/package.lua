return {
  name = "sway",
  version = "1.11",
  description = "i3-compatible tiling Wayland compositor, built on wlroots. Depends specifically on wlroots 0.19.0 per its own release notes.",
  license = "MIT",
  homepage = "https://swaywm.org",

  sources = {
    {
      url = "https://github.com/swaywm/sway/archive/refs/tags/1.11.tar.gz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "wlroots" },
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "pcre2" },
    { name = "json-c" },
    { name = "pango" },
    { name = "cairo" },
    { name = "gdk-pixbuf" },
    { name = "scdoc", build_only = true },
  },

  build = {
    "meson setup build --prefix=$out -Dman-pages=enabled",
    "ninja -C build install",
  },
}
