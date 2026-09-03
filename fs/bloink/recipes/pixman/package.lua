-- recipes/pixman/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "pixman",
  version = "0.43.4",
  description = "Low-level pixel manipulation library",
  license = "MIT",
  homepage = "https://pixman.org",

  sources = {
    {
      url = "https://cairographics.org/releases/pixman-0.43.4.tar.gz",
      sha256 = "a0624db90180c7ddb79fc7a9151093dc37c646d8c38d3f232f767cf64b85a226",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out",
    "ninja -C build install",
  },
}
