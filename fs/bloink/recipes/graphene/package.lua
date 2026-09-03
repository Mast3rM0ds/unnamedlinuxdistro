-- recipes/graphene/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "graphene",
  version = "1.10.8",
  description = "Thin layer of graphic data types (used by GTK4)",
  license = "MIT",
  homepage = "https://ebassi.github.io/graphene/",

  sources = {
    {
      url = "https://github.com/ebassi/graphene/releases/download/1.10.8/graphene-1.10.8.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
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
