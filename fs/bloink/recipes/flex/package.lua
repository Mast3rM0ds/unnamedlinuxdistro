return {
	name = "flex",
	version = "2.6.4",
	description = "The Flex package contains a utility for generating programs that recognize patterns in text. - Linux From Scratch 2026",
	license = "LGPL-3.0-or-later",
	homepage = "https://github.com/westes/flex",

	sources = {
		{
			url = "https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz",
			sha256 = "e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
