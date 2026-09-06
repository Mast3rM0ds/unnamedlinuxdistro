return {
	name = "m4",
	version = "1.4.21",
	description = "The M4 package contains a macro processor. - Linux From Scratch 2026",
	license = "LGPL-3.0-or-later",
	homepage = "https://www.mpfr.org/",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/m4/m4-1.4.21.tar.gz",
			sha256 = "38ae59f7a30bf9c108193cc5c25fbb06014f21e230c7ede2eff614f7b7c37ed8",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
