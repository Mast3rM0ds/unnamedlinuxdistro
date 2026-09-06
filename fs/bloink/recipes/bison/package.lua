return {
	name = "bison",
	version = "3.8",
	description =
	"Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.",
	license = "LGPL-3.0-OR-LATER",
	homepage = "https://www.gnu.org/software/bison/",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/bison/bison-3.8.tar.gz",
			sha256 = "d5d184d421aee15603939973a6b0f372f908edfb24c5bc740697497021ad9458",
		},
	},

	deps = {
		"m4",
	},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
