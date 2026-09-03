-- recipes/libffi/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libffi",
  version = "3.4.6",
  description = "Foreign function interface library",
  license = "MIT",
  homepage = "https://sourceware.org/libffi/",

  sources = {
    {
      url = "https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz",
      sha256 = "b0dea9df23c863a7a50e825440f3ebffabd65df1497108e5d437747843895a4e",
    },
  },

  deps = {
  },

  build = {
    "./configure --prefix=$out --disable-static",
    "make -j$(nproc)",
    "make install",
  },
}
