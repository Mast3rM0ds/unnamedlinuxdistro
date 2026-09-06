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
