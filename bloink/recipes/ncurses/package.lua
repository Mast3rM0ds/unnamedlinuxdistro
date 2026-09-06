return {
	name = "ncurses",
	version = "1.3.1",
	description = "Compression library used by nearly everything downstream",
	license = "MIT",
	homepage = "https://invisible-island.net/ncurses/",

	sources = {
		{
			url = "https://mirrors.dotsrc.org/gnu/ncurses/ncurses-6.6.tar.gz",
			sha256 = "355b4cbbed880b0381a04c46617b7656e362585d52e9cf84a67e2009b749ff11",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
