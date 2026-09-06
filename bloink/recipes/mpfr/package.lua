return {
	name = "mpfr",
	version = "4.2.1",
	description = "GNU Multiple Precision Floating-Point Reliable Library",
	license = "LGPL-3.0-or-later",
	homepage = "https://www.mpfr.org/",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz",
			sha256 = "277807353a6726978996945af13e52829e3abd7a9a5b7fb2793894e18f1fcbb2",
		},
	},

	deps = {
		"gmp",
	},

	build = {
		"./configure --prefix=$out --enable-static --disable-shared",
		"make -j$(nproc)",
		"make install",
	},
}
