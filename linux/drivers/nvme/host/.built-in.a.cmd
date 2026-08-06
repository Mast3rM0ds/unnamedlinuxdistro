savedcmd_drivers/nvme/host/built-in.a := rm -f drivers/nvme/host/built-in.a;  printf "drivers/nvme/host/%s " core.o ioctl.o sysfs.o pr.o trace.o pci.o | xargs ar cDPrST drivers/nvme/host/built-in.a
