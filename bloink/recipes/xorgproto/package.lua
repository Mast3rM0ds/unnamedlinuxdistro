-- recipes/xorgproto/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "xorgproto",
  version = "2024.1",
  description = "X11 protocol headers (no library, headers only)",
  license = "MIT",
  homepage = "https://gitlab.freedesktop.org/xorg/proto/xorgproto",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
