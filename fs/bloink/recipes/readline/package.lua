return {
	name = "readline",
	version = "8.3",
	description =
	"The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.",
	license = "LGPL-3.0-or-later",
	homepage = "https://tiswww.cwru.edu/php/chet/readline/rltop.html",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/readline/readline-8.3.tar.gz",
			sha256 = "fe5383204467828cd495ee8d1d3c037a7eba1389c22bc6a041f627976f9061cc",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
