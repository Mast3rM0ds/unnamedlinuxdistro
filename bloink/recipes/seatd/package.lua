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
