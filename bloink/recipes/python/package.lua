return {
	name = "python",
	version = "3.13.7",
	description = "Python programming language",
	license = "PSF-2.0",
	homepage = "https://www.python.org/",

	sources = {
		{
			url = "https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz",
			sha256 = "5462f9099dfd30e238def83c71d91897d8caa5ff6ebc7a50f14d4802cdaaa79a",
		},
	},

	deps = {
		"zlib",
		"bzip2",
		"xz",
		"libffi",
		"openssl",
		"readline",
		"sqlite",
		"ncurses",
	},

	build = {
		"./configure --prefix=$out --enable-static --disable-shared --with-ensurepip=install",
		"make -j$(nproc)",
		"make install",
	},
}
