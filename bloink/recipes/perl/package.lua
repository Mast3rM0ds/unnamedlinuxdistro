return {
	name = "perl",
	version = "5.44.0",
	description = "THE WORST FUCKING PROGRAM EVER!!!",
	license = "ARTISTIC",
	homepage = "https://perlfoundation.org/",

	sources = {
		{
			url = "https://www.cpan.org/src/5.0/perl-5.44.0.tar.gz",
			sha256 = "3b855066b92491cb40e86affb1ca57d1a388aa43e51b91c7806a32c2f65f96c3",
		},
	},

	deps = {},

	build = {
		"export BUILD_ZLIB=False",
		"export BUILD_BZIP2=0",
		"sh Configure -des -D prefix=$out -D vendorprefix=$out -D privlib=$out/lib/perl5/5.42/core_perl  -D archlib=$out/lib/perl5/5.42/core_perl -D sitelib=$out/lib/perl5/5.42/site_perl -D sitearch=$out/lib/perl5/5.42/site_perl -D vendorlib=$out/lib/perl5/5.42/vendor_perl -D vendorarch=$out/lib/perl5/5.42/vendor_perl -D man1dir=$out/share/man/man1 -D man3dir=$out/share/man/man3 -D useshrplib -D usethreads",
		"make -j$(nproc)",
		"make install",
	},
}
