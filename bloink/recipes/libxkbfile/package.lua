return {
  name = "libxkbfile",
  version = "1.1.3",
  description = "XKB file format library (used by X servers/compositors)",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libxkbfile-1.1.3.tar.gz",
      sha256 = "c4c2687729d1f920f165ebb96557a1ead2ef655809ab5eaa66a1ad36dc31050d",
    },
  },

  deps = {
    { name = "libx11" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
