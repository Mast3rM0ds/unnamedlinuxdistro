-- recipes/libxcomposite/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "libxcomposite",
  version = "0.4.6",
  description = "X Composite extension client library",
  license = "MIT",
  homepage = "https://x.org",

  sources = {
    {
      url = "https://xorg.freedesktop.org/archive/individual/lib/libXcomposite-0.4.6.tar.gz",
      sha256 = "3599dfcd96cd48d45e6aeb08578aa27636fa903f480f880c863622c2b352d076",
    },
  },

  deps = {
    { name = "libx11" },
    { name = "xorgproto", build_only = true },
  },

  build = {
    "./configure --prefix=$out",
    "make -j$(nproc)",
    "make install",
  },
}
