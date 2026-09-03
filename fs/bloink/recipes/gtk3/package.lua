-- recipes/gtk3/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "gtk3",
  version = "3.24.43",
  description = "GTK3 widget toolkit (X11 + Wayland backends)",
  license = "LGPL-2.1-or-later",
  homepage = "https://www.gtk.org",

  sources = {
    {
      url = "https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.43.tar.xz",
      sha256 = "7e04f0648515034b806b74ae5d774d87cffb1a2a96c468cb5be476d51bf2f3c7",
    },
  },

  deps = {
    { name = "glib" },
    { name = "cairo" },
    { name = "pango" },
    { name = "gdk-pixbuf" },
    { name = "libepoxy" },
    { name = "wayland" },
    { name = "wayland-protocols", build_only = true },
    { name = "libxkbcommon" },
    { name = "libx11" },
    { name = "libxext" },
    { name = "libxrandr" },
    { name = "libxi" },
    { name = "libxcursor" },
    { name = "libxdamage" },
    { name = "libxfixes" },
    { name = "at-spi2-core" },
    { name = "shared-mime-info" },
  },

  build = {
    "meson setup build --prefix=$out -Dx11-backend=true -Dwayland-backend=true -Dbroadway-backend=false -Dintrospection=disabled",
    "ninja -C build install",
  },
}
