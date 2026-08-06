savedcmd_arch/x86/entry/vdso/vdso32/note.o := gcc -Wp,-MMD,arch/x86/entry/vdso/vdso32/.note.o.d -nostdinc -I./arch/x86/include -I./arch/x86/include/generated -I./include -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -Werror -D__ASSEMBLY__ -Wa,--fatal-warnings -DBUILD_VDSO32 -m32 -mregparm=0 -include ./arch/x86/entry/vdso/vdso32/fake_32bit_build.h -D__DISABLE_EXPORTS -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO -I./arch/x86/entry/vdso/vdso32/.. -I. -O2 -fpic -fno-stack-protector -fno-omit-frame-pointer -foptimize-sibling-calls -fasynchronous-unwind-tables -fcf-protection=none -mindirect-branch=thunk-inline -mindirect-branch-register    -DKBUILD_MODFILE='"arch/x86/entry/vdso/vdso32/note"' -DKBUILD_MODNAME='"note"' -D__KBUILD_MODNAME=note -c -o arch/x86/entry/vdso/vdso32/note.o arch/x86/entry/vdso/vdso32/note.S 

source_arch/x86/entry/vdso/vdso32/note.o := arch/x86/entry/vdso/vdso32/note.S

deps_arch/x86/entry/vdso/vdso32/note.o := \
  include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  arch/x86/entry/vdso/vdso32/fake_32bit_build.h \
    $(wildcard include/config/X86_64) \
    $(wildcard include/config/64BIT) \
    $(wildcard include/config/COMPAT) \
    $(wildcard include/config/PGTABLE_LEVELS) \
    $(wildcard include/config/ILLEGAL_POINTER_VALUE) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP) \
    $(wildcard include/config/HUGETLB_PAGE_OPTIMIZE_VMEMMAP) \
    $(wildcard include/config/NR_CPUS) \
    $(wildcard include/config/PARAVIRT_XXL) \
    $(wildcard include/config/X86_32) \
    $(wildcard include/config/PAGE_OFFSET) \
  arch/x86/entry/vdso/vdso32/../common/note.S \
  include/linux/build-salt.h \
    $(wildcard include/config/BUILD_SALT) \
  include/linux/elfnote.h \
  include/generated/uapi/linux/version.h \

arch/x86/entry/vdso/vdso32/note.o: $(deps_arch/x86/entry/vdso/vdso32/note.o)

$(deps_arch/x86/entry/vdso/vdso32/note.o):
