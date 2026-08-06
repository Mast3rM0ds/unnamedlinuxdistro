# cannot find fixdep (/home/sonakrie/Work/linux-7.1.7/tools/objtool//fixdep)
# using basic dep data

/home/sonakrie/Work/linux-7.1.7/tools/objtool/fixdep.o: fixdep.c \
 /usr/include/stdc-predef.h /usr/include/sys/types.h \
 /usr/include/features.h /usr/include/bits/alltypes.h \
 /usr/include/endian.h /usr/include/sys/select.h /usr/include/sys/stat.h \
 /usr/include/bits/stat.h /usr/include/sys/mman.h \
 /usr/include/bits/mman.h /usr/include/unistd.h /usr/include/fcntl.h \
 /usr/include/bits/fcntl.h /usr/include/string.h /usr/include/strings.h \
 /usr/include/stdlib.h /usr/include/alloca.h /usr/include/stdio.h \
 /usr/include/limits.h /usr/include/bits/limits.h

cmd_/home/sonakrie/Work/linux-7.1.7/tools/objtool/fixdep.o := gcc -Wp,-MD,/home/sonakrie/Work/linux-7.1.7/tools/objtool/.fixdep.o.d -Wp,-MT,/home/sonakrie/Work/linux-7.1.7/tools/objtool/fixdep.o -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11   -I ./scripts/include -Werror -D"BUILD_STR(s)=$(pound)s"   -c -o /home/sonakrie/Work/linux-7.1.7/tools/objtool/fixdep.o fixdep.c
