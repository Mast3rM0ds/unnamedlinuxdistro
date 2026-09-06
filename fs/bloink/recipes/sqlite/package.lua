return {
	name = "sqlite",
	version = "3.53.4",
	description =
	"SQLite is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine.",
	license = "None",
	homepage = "https://sqlite.org/index.html",

	sources = {
		{
			url = "https://sqlite.org/2026/sqlite-autoconf-3530400.tar.gz",
			sha256 = "0e9483900e92cd5de8fd48d16bf9200145a61f7fd5be542a5ac81d8a9516eb9c",
		},
	},

	deps = {},

	build = {
		"./configure --prefix=$out",
		"make -j$(nproc)",
		"make install",
	},
}
