return {
  name = "scdoc",
  version = "1.11.3",
  description = "Man page generator using its own simple markup (build-time only, for wlroots/sway man pages)",
  license = "MIT",
  homepage = "https://git.sr.ht/~sircmpwn/scdoc",

  sources = {
    {
      url = "https://git.sr.ht/~sircmpwn/scdoc/archive/1.11.3.tar.gz",
      sha256 = "4c5c6136540384e5455b250f768e7ca11b03fdba1a8efc2341ee0f1111e57612",
    },
  },

  deps = {
  },

  build = {
    "make PREFIX=$out",
    "make PREFIX=$out install",
  },
}
