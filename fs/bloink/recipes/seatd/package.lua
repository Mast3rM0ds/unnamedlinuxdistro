-- recipes/seatd/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "seatd",
  version = "0.9.1",
  description = "Minimal seat/session management daemon and library (init-agnostic)",
  license = "MIT",
  homepage = "https://sr.ht/~kennylevinsen/seatd/",

  sources = {
    {
      url = "https://git.sr.ht/~kennylevinsen/seatd/archive/0.9.1.tar.gz",
      sha256 = "819979c922a0be258aed133d93920bce6a3d3565a60588d6d372ce9db2712cd3",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out -Dlibseat-seatd=enabled -Dserver=enabled",
    "ninja -C build install",
  },
}
