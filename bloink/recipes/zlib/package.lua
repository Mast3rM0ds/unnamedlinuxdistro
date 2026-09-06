-- Good for templates.
return {
	name = "zlib",
	version = "1.3.1",
	description = "Compression library used by nearly everything downstream",
	license = "Zlib",
	homepage = "https://zlib.net",

	sources = {
		{
			url = "https://codeload.github.com/madler/zlib/tar.gz/refs/tags/v1.3.1",
			sha256 = "17e88863f3600672ab49182f217281b6fc4d3c762bde361935e436a95214d05c",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out --static",
		"make -j$(nproc)",
		"make install",
	},
}
