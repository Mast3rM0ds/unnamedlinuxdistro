cd cpan/Archive-Tar
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/Attribute-Handlers
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/AutoLoader.pm
rm -f lib/AutoSplit.pm
cd cpan/CPAN
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd cpan/CPAN-Meta
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/CPAN/Meta/Requirements.pm
rm -f lib/CPAN/Meta/Requirements/Range.pm
cd cpan/CPAN-Meta-YAML
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Carp.pm
rm -f lib/Carp/Heavy.pm
rm -f lib/Config/Perl/V.pm
rm -f lib/Devel/SelfStubber.pm
rm -f lib/Digest.pm
rm -f lib/Digest/base.pm
rm -f lib/Digest/file.pm
rm -f lib/Env.pm
rm -f lib/Dumpvalue.pm
cd ext/Errno
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/Exporter
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/ExtUtils/CBuilder.pm
rm -f lib/ExtUtils/CBuilder/Base.pm
rm -f lib/ExtUtils/CBuilder/Platform/Unix.pm
rm -f lib/ExtUtils/CBuilder/Platform/VMS.pm
rm -f lib/ExtUtils/CBuilder/Platform/Windows.pm
rm -f lib/ExtUtils/CBuilder/Platform/Windows/BCC.pm
rm -f lib/ExtUtils/CBuilder/Platform/Windows/GCC.pm
rm -f lib/ExtUtils/CBuilder/Platform/Windows/MSVC.pm
rm -f lib/ExtUtils/CBuilder/Platform/aix.pm
rm -f lib/ExtUtils/CBuilder/Platform/android.pm
rm -f lib/ExtUtils/CBuilder/Platform/cygwin.pm
rm -f lib/ExtUtils/CBuilder/Platform/darwin.pm
rm -f lib/ExtUtils/CBuilder/Platform/dec_osf.pm
rm -f lib/ExtUtils/CBuilder/Platform/os2.pm
rm -f lib/ExtUtils/Constant.pm
rm -f lib/ExtUtils/Constant/Base.pm
rm -f lib/ExtUtils/Constant/ProxySubs.pm
rm -f lib/ExtUtils/Constant/Utils.pm
rm -f lib/ExtUtils/Constant/XS.pm
rm -f lib/ExtUtils/Install.pm
rm -f lib/ExtUtils/Installed.pm
rm -f lib/ExtUtils/Packlist.pm
cd cpan/ExtUtils-MakeMaker
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd cpan/ExtUtils-Manifest
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/ExtUtils/Miniperl.pm
rm -f lib/ExtUtils/PL2Bat.pm
rm -f lib/File/Fetch.pm
rm -f lib/File/Find.pm
cd dist/ExtUtils-ParseXS
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/File/Path.pm
rm -f lib/File/Temp.pm
rm -f lib/FileCache.pm
cd dist/Filter-Simple
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/FindBin
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Getopt/Long.pm
rm -f lib/Getopt/Long/Parser.pm
rm -f lib/I18N/Collate.pm
cd cpan/HTTP-Tiny
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/lib
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/I18N-LangTags
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/IO/Socket/IP.pm
rm -f lib/IO/Zlib.pm
rm -f lib/IPC/Cmd.pm
rm -f lib/IPC/Open2.pm
rm -f lib/IPC/Open3.pm
rm -f lib/Locale/Maketext/Simple.pm
cd dist/Locale-Maketext
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd cpan/JSON-PP
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Math/BigFloat.pm
rm -f lib/Math/BigInt.pm
rm -f lib/Math/BigInt/Calc.pm
rm -f lib/Math/BigInt/Lib.pm
rm -f lib/Math/BigRat.pm
rm -f lib/Memoize.pm
rm -f lib/Memoize/AnyDBM_File.pm
rm -f lib/Memoize/Expire.pm
rm -f lib/Memoize/NDBM_File.pm
rm -f lib/Memoize/SDBM_File.pm
rm -f lib/Memoize/Storable.pm
cd dist/Math-Complex
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Module/Load.pm
rm -f lib/Module/Load/Conditional.pm
rm -f lib/Module/Loaded.pm
cd dist/Module-CoreList
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/NEXT.pm
cd cpan/Module-Metadata
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/Net-Ping
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Params/Check.pm
rm -f lib/Perl/OSType.pm
rm -f lib/PerlIO/scalar.pm
rm -f lib/PerlIO/via/QuotedPrint.pm
rm -f lib/Pod/Escapes.pm
cd cpan/Pod-Checker
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/if
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd ext/Pod-Html
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Safe.pm
rm -f lib/Search/Dict.pm
cd cpan/Pod-Perldoc
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Term/ANSIColor.pm
cd cpan/Pod-Usage
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/SelfLoader
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Term/Complete.pm
cd cpan/Term-Cap
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Term/ReadLine.pm
rm -f lib/Term/Table.pm
rm -f lib/Term/Table/Cell.pm
rm -f lib/Term/Table/CellStack.pm
rm -f lib/Term/Table/HashBase.pm
rm -f lib/Term/Table/LineBreak.pm
rm -f lib/Term/Table/Spacer.pm
rm -f lib/Term/Table/Util.pm
cd dist/Test
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd cpan/Test-Harness
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Text/Abbrev.pm
cd cpan/Test-Simple
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Text/Balanced.pm
rm -f lib/Text/ParseWords.pm
rm -f lib/Text/Tabs.pm
rm -f lib/Text/Wrap.pm
cd dist/Thread-Queue
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/Thread-Semaphore
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/Tie-File
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Tie/Hash/NamedCapture.pm
rm -f lib/Tie/Memoize.pm
rm -f lib/Tie/RefHash.pm
rm -f lib/Time/Local.pm
rm -f lib/Fatal.pm
rm -f lib/autodie.pm
rm -f lib/autodie/Scope/Guard.pm
rm -f lib/autodie/Scope/GuardStack.pm
rm -f lib/autodie/Util.pm
rm -f lib/autodie/exception.pm
rm -f lib/autodie/exception/system.pm
rm -f lib/autodie/hints.pm
rm -f lib/autodie/skip.pm
rm -f lib/autouse.pm
cd dist/XSLoader
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/base
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd dist/constant
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd cpan/bignum
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/experimental.pm
rm -f lib/stable.pm
rm -f lib/parent.pm
rm -f lib/perlfaq.pm
rm -f lib/perlfaq.pod
rm -f lib/perlfaq1.pod
rm -f lib/perlfaq2.pod
rm -f lib/perlfaq3.pod
rm -f lib/perlfaq4.pod
rm -f lib/perlfaq5.pod
rm -f lib/perlfaq6.pod
rm -f lib/perlfaq7.pod
rm -f lib/perlfaq8.pod
rm -f lib/perlfaq9.pod
rm -f lib/perlglossary.pod
cd dist/encoding-warnings
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/version.pm
rm -f lib/version.pod
rm -f lib/version/Internals.pod
rm -f lib/version/regex.pm
cd cpan/libnet
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd cpan/podlators
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
rm -f lib/Pod/Simple.pm
rm -f lib/Pod/Simple.pod
rm -f lib/Pod/Simple/BlackBox.pm
rm -f lib/Pod/Simple/Checker.pm
rm -f lib/Pod/Simple/Debug.pm
rm -f lib/Pod/Simple/DumpAsText.pm
rm -f lib/Pod/Simple/DumpAsXML.pm
rm -f lib/Pod/Simple/HTML.pm
rm -f lib/Pod/Simple/HTMLBatch.pm
rm -f lib/Pod/Simple/HTMLLegacy.pm
rm -f lib/Pod/Simple/JustPod.pm
rm -f lib/Pod/Simple/LinkSection.pm
rm -f lib/Pod/Simple/Methody.pm
rm -f lib/Pod/Simple/Progress.pm
rm -f lib/Pod/Simple/PullParser.pm
rm -f lib/Pod/Simple/PullParserEndToken.pm
rm -f lib/Pod/Simple/PullParserStartToken.pm
rm -f lib/Pod/Simple/PullParserTextToken.pm
rm -f lib/Pod/Simple/PullParserToken.pm
rm -f lib/Pod/Simple/RTF.pm
rm -f lib/Pod/Simple/Search.pm
rm -f lib/Pod/Simple/SimpleTree.pm
rm -f lib/Pod/Simple/Subclassing.pod
rm -f lib/Pod/Simple/Text.pm
rm -f lib/Pod/Simple/TextContent.pm
rm -f lib/Pod/Simple/TiedOutFH.pm
rm -f lib/Pod/Simple/Transcode.pm
rm -f lib/Pod/Simple/TranscodeDumb.pm
rm -f lib/Pod/Simple/TranscodeSmart.pm
rm -f lib/Pod/Simple/XHTML.pm
rm -f lib/Pod/Simple/XMLOutStream.pm
cd cpan/IO-Compress
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd ext/Pod-Functions
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a
fi
cd ../..
cd ext/DynaLoader
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=static CCCDLFLAGS=
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=static CCCDLFLAGS=
fi
cd ../..
cd cpan/Compress-Raw-Bzip2
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Compress-Raw-Zlib
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/B
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/PathTools
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/Data-Dumper
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/Devel-PPPort
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/Devel-Peek
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Digest-MD5
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Digest-SHA
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Encode
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/Fcntl
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/File-DosGlob
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/File-Glob
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Filter-Util-Call
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/Hash-Util
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/Hash-Util-FieldHash
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/I18N-Langinfo
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/IO
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/IPC-SysV
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Scalar-List-Utils
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/MIME-Base64
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/Opcode
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/POSIX
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/PerlIO-encoding
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/PerlIO-mmap
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/PerlIO-via
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/SDBM_File
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Socket
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/Storable
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/Sys-Hostname
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Sys-Syslog
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Time-Piece
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Unicode-Collate
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/Time-HiRes
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/XS-APItest
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/XS-Typemap
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/attributes
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/mro
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd ext/re
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/threads
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/threads-shared
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd cpan/Math-BigInt-FastCalc
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
cd dist/Unicode-Normalize
if test ! -f Makefile -a -f Makefile.old; then
    echo "Note: Using Makefile.old"
    make -f Makefile.old realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
else
    if test ! -f Makefile ; then
	echo "Warning: No Makefile!"
    fi
    make realclean MAKE='make' PERL_CORE=1 LIBPERL_A=libperl.a LINKTYPE=dynamic
fi
cd ../..
