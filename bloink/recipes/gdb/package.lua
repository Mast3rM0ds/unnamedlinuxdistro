return {
	name = "gdb",
	version = "17.2",
	description = "GNU Debugger useful for debugging programs that dont work as expected",
	license = "GNU-GPL",
	homepage = "https://www.sourceware.org/gdb/",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/gdb/gdb-17.2.tar.gz",
			sha256 = "cb891b9a9f554cac972eea5368176b240640ae90b681aae84bf873a9501f0063",
		},
	},

	deps = {
		"gmp",
		"mpfr",
	},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
