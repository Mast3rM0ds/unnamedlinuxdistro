savedcmd_drivers/iommu/amd/built-in.a := rm -f drivers/iommu/amd/built-in.a;  printf "drivers/iommu/amd/%s " iommu.o init.o quirks.o ppr.o pasid.o | xargs ar cDPrST drivers/iommu/amd/built-in.a
