return {
  name = "pcre2",
  version = "10.44",
  description = "Perl-compatible regular expressions, v2 (sway criteria matching)",
  license = "BSD-3-Clause",
  homepage = "https://github.com/PCRE2Project/pcre2",

  sources = {
    {
      url = "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.gz",
      sha256 = "PIN_ME"
    },
  },

  deps = {
  },

  build = {
    "./configure --prefix=$out --enable-shared --disable-static",
    "make -j$(nproc)",
    "make install",
  },
}
