return {
	name = "diffutils",
	version = "3.12",
	description = "Diffutils is a package of several programs related to finding differences between files.",
	license = "LGPL-3.0-or-later",
	homepage = "https://www.gnu.org/software/diffutils/",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.gz",
			sha256 = "5be181b27ec38aad2450080661a64e4a1752bb29b7d5052bf0a02a70f623f9b2",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
