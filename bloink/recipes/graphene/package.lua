return {
  name = "graphene",
  version = "1.10.8",
  description = "Thin layer of graphic data types (used by GTK4)",
  license = "MIT",
  homepage = "https://ebassi.github.io/graphene/",

  sources = {
    {
      url = "https://github.com/ebassi/graphene/releases/download/1.10.8/graphene-1.10.8.tar.xz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
    { name = "glib" },
  },

  build = {
    "meson setup build --prefix=$out -Dtests=false",
    "ninja -C build install",
  },
}
