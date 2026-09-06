return {
  name = "libxml2",
  version = "2.12.7",
  description = "XML parsing library",
  license = "MIT",
  homepage = "https://gitlab.gnome.org/GNOME/libxml2",

  sources = {
    {
      url = "https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.7.tar.xz",
      sha256 = "24ae78ff1363a973e6d8beba941a7945da2ac056e19b53956aeb6927fd6cfb56",
    },
  },

  deps = {
    { name = "zlib" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
