hello uhh to boot this you need to run this(you need qemu-system-x86 installed)

cd fs
find . -mindepth 1 -printf '%P\n' | cpio -o -H newc | gzip > ../init.cpio
cd ..
qemu-system-x86_64 -kernel linux/arch/x86/boot/bzImage -initrd init.cpio -append "rdinit=/sbin/openrc-init" -m 4094

adding stuff to the filesystem is simple the entire filesystem is in fs/

---------------------
compiling and installing programs
---------------------

WE GOT THAT NEW PACKAGE MANAGER BABY!
inside of bloink/recipes in the root of the repo you may notice theres a LOT of packages already so copy one of those and adjust the lua file which is so much more better!
----------------------

if you wish to actually not use bloink(WHY NOT!?) and make it like integrated into this live testing thing you can either download the program's tarball and untar then remove the tarball,
if the tar comes in something like package-version so "openssl-4.0.1" change it to just the package name like "openssl"
if its a git then please remove the .git inside of that package


you can go ahead and check if the build instructions is in like README or INSTALL or CONTRIBUTIONS

most packages uses autoconf so just run ./configure --prefix=../fs
then run make -j$(nproc)
and the to install run make DESTDIR="../fs" install

thats if it uses autoconf and make other programs can be different just RTFM

thats about it.
