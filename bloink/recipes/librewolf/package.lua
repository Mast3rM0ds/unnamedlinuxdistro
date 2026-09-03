-- recipes/librewolf/package.lua
-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because
-- this build environment can't reach the upstream host to fetch and
-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).
-- Run tools/bloink-pin on this file from a machine with normal internet
-- access before `bloink build` will accept it.
return {
  name = "librewolf",
  version = "128.0-1",
  description = "Privacy-hardened Firefox fork (the package nixpkgs support for is notoriously weak) — recipe stubbed pending real build integration",
  license = "MPL-2.0",
  homepage = "https://librewolf.net",

  sources = {
    {
      url = "https://gitlab.com/librewolf-community/browser/source/-/archive/128.0-1/source-128.0-1.tar.gz",
      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in
    },
  },

  deps = {
    { name = "gtk3" },
    { name = "dbus" },
    { name = "pango" },
    { name = "cairo" },
    { name = "fontconfig" },
    { name = "freetype" },
    { name = "libx11" },
    { name = "libxext" },
    { name = "libxrandr" },
    { name = "libxi" },
    { name = "libxcomposite" },
    { name = "libxdamage" },
    { name = "libxfixes" },
    { name = "libxtst" },
  },

  build = {
    "echo 'librewolf vendors its own toolchain (rust, node) and mozconfig; ' 'wire up ./mach build --prefix=\$out here once bloink supports a build-time ' 'network allowance for the vendored cargo/npm fetches' >&2",
    "false",
  },
}
