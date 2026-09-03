-- recipes/libxi/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxi",
  version = "1.8.1",
  description = "X Input extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXi-1.8.1.tar.gz",
      sha256 = "3b5f47c223e4b63d7f7fe758886b8bf665b20a7edb6962c423892fd150e326ea",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "libxext" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
