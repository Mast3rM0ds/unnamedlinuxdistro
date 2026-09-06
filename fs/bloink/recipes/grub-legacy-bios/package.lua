return {
	name = "grub-legacy-bios",
	version = "2.14",
	description =
	"The GRUB package contains the GRand Unified Bootloader. - Linux From Scratch 2026(great description lfs!)",
	license = "LGPL-3.0-OR-LATER",
	homepage = "https://www.gnu.org/software/grub/",

	sources = {
		{
			url = "https://ftp.gnu.org/gnu/grub/grub-2.14.tar.gz",
			sha256 = "d0415fbb3e739237064e173743a6e5f60c33a81ec02a069cc9152d80efff4967",
		},
	},

	deps = {
		"bison",
	},

	build = {
		"sed 's/--image-base/--nonexist-linker-option/' -i configure",
		"./configure --prefix=$out --sysconfdir=/etc --disable-efiemu --disable-werror",
		"make -j$(nproc)",
		"make install",
	},
}
