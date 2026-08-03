hello uhh to boot this you need to run this(you need qemu-system-x86 installed)

cd fs
find . -mindepth 1 -printf '%P\n' | cpio -o -H newc | gzip > ../init.cpio
cd ..
qemu-system-x86_64 -kernel linux/arch/x86/boot/bzImage -initrd init.cpio -append "rdinit=/sbin/openrc-init" -m 4094

adding stuff to the filesystem is simple the entire filesystem is in fs/

---------------------
compiling and installing programs
---------------------

now we have APK(alpine package keeper)
so you can use a alpine container or if you have it on a spare laptop or if its installed on your system/bedrock linux
you can head over to ports/ and then run newapkbuild and then the name so for example "newapkbuild wayland"
just read https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package at this point.
----------------------

if you wish to actually not use apk and make it like integrated into this live testing thing you can either download the program's tarball and untar then remove the tarball,
if the tar comes in something like package-version so "openssl-4.0.1" change it to just the package name like "openssl"
if its a git then please remove the .git inside of that package


you can go ahead and check if the build instructions is in like README or INSTALL or CONTRIBUTIONS

most packages uses autoconf so just run ./configure --prefix=../fs
then run make -j$(nproc)
and the to install run make DESTDIR="../fs" install

thats if it uses autoconf and make other programs can be different just RTFM

thats about it.
