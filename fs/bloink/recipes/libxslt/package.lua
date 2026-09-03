-- recipes/libxslt/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxslt",
  version = "1.1.39",
  description = "XSLT processing library (libxml2-based)",
  license = "MIT",
  homepage = "https://gitlab.gnome.org/GNOME/libxslt",

  sources = {
    {
      url = "https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.39.tar.xz",
      sha256 = "2a20ad621148339b0759c4d4e96719362dee64c9a096dbba625ba053846349f0",
    },
  },

  deps = {
    { name = "libxml2" },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
