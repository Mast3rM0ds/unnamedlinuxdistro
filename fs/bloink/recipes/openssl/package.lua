return {
	name = "openssl",
	version = "4.0.2",
	description = "Compression library used by nearly everything downstream",
	license = "APACHE",
	homepage = "https://www.openssl-library.org/",

	sources = {
		{
			url = "https://github.com/openssl/openssl/releases/download/openssl-4.0.2/openssl-4.0.2.tar.gz",
			sha256 = "736b467530f916737b7031310ccb21d8218c6229e61e8e160cd1d3458cd543a8",
		},
	},

	deps = {
		"perl",
	},

	build = {
		"./Configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
