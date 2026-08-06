savedcmd_fs/exfat/built-in.a := rm -f fs/exfat/built-in.a;  printf "fs/exfat/%s " inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o file.o balloc.o | xargs ar cDPrST fs/exfat/built-in.a
