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

	deps = {
		{ name = "zlib" },
		{ name = "bzip2" },
	},

	build = {
		"find . -path '*/Compress-Raw-Zlib/config.in' -exec sh -c 'printf \"BUILD_ZLIB = False\\nZLIB_INCLUDE = %s/include\\nZLIB_LIB = %s/lib\\nOLD_ZLIB = False\\nGZIP_OS_CODE = AUTO_DETECT\\nUSE_ZLIB_NG = False\\n\" \"$BLOINK_DEP_ZLIB\" \"$BLOINK_DEP_ZLIB\" > \"$1\"' _ {} \\;",
		"find . -path '*/Compress-Raw-Bzip2/config.in' -exec sh -c 'printf \"BUILD_BZIP2 = False\\nBZIP2_INCLUDE = %s/include\\nBZIP2_LIB = %s/lib\\n\" \"$BLOINK_DEP_BZIP2\" \"$BLOINK_DEP_BZIP2\" > \"$1\"' _ {} \\;",
		"sh Configure -des -D prefix=$out -D vendorprefix=$out -D privlib=$out/lib/perl5/5.44/core_perl  -D archlib=$out/lib/perl5/5.44/core_perl -D sitelib=$out/lib/perl5/5.44/site_perl -D sitearch=$out/lib/perl5/5.44/site_perl -D vendorlib=$out/lib/perl5/5.44/vendor_perl -D vendorarch=$out/lib/perl5/5.44/vendor_perl -D man1dir=$out/share/man/man1 -D man3dir=$out/share/man/man3 -D useshrplib -D usethreads",
		"make -j$(nproc)",
		"make install",
	},
}
