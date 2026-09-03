savedcmd_vmlinux.o := ld -m elf_x86_64 --fatal-warnings -z noexecstack --no-warn-rwx-segments -r -o vmlinux.o   --whole-archive vmlinux.a --no-whole-archive --start-group  --end-group  ; ./tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --prefix=16 --orc --retpoline --rethunk --static-call --uaccess --noinstr  --unret --link vmlinux.o

vmlinux.o: $(wildcard ./tools/objtool/objtool)
