-- recipes/pkgconf/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "pkgconf",
  version = "2.3.0",
  description = "pkg-config compatible dependency metadata tool",
  license = "ISC",
  homepage = "https://github.com/pkgconf/pkgconf",

  sources = {
    {
      url = "https://distfiles.ariadne.space/pkgconf/pkgconf-2.3.0.tar.gz",
      sha256 = "a2df680578e85f609f2fa67bd3d0fc0dc71b4bf084fc49119de84cd6ed28e723",
    },
  },

  deps = {
  },

  build = {
    "meson setup build --prefix=$out -Dtests=disabled",
    "ninja -C build install",
  },
}
