return {
  name = "gtk4",
  version = "4.14.4",
  description = "GTK4 widget toolkit (X11 + Wayland backends)",
  license = "LGPL-2.1-or-later",
  homepage = "https://www.gtk.org",

  sources = {
    {
      url = "https://download.gnome.org/sources/gtk/4.14/gtk-4.14.4.tar.xz",
      sha256 = "443518b97e8348f9f6430ac435b1010f9a6c5207f4dc6a7cd5d24e3820cee633",
    },
  },

  deps = {
    { name = "glib" },
    { name = "cairo" },
    { name = "pango" },
    { name = "gdk-pixbuf" },
    { name = "libepoxy" },
    { name = "graphene" },
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
  },

  build = {
    "meson setup build --prefix=$out -Dx11-backend=true -Dwayland-backend=true -Dbroadway-backend=false -Dintrospection=disabled -Dmedia-gstreamer=disabled",
    "ninja -C build install",
  },
}
