return {
	name = "xz",
	version = "5.8.3",
	description = "XZ Utils are a complete C99 implementation of the .xz file format.",
	license = "BSD-LGPL-2.0",
	homepage = "https://tukaani.org/xz/",

	sources = {
		{
			url = "https://github.com/tukaani-project/xz/releases/download/v5.8.3/xz-5.8.3.tar.gz",
			sha256 = "3d3a1b973af218114f4f889bbaa2f4c037deaae0c8e815eec381c3d546b974a0",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
