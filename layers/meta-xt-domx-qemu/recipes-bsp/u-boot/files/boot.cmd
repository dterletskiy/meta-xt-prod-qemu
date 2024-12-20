setenv XEN_ADDRESS         0x50000000
setenv XEN_SIZE            0x0
setenv XEN_CMDLINE         "dom0_mem=3G,max:3G loglvl=all guest_loglvl=all console=dtuart"
setenv DTB_ADDRESS         0x51000000
setenv KERNEL_ADDRESS      0x60000000
setenv KERNEL_SIZE         0x0
setenv KERNEL_CMDLINE      "root=/dev/ram verbose loglevel=7 console=hvc0 earlyprintk=xen"
setenv ROOTFS_ADDRESS      0x52000000
setenv ROOTFS_SIZE         0x0



setenv patch_dtb_chosen '
   echo "-----"; \
   fdt resize; \
   echo "-----"; \
   fdt set /chosen \\#address-cells <1>; \
   echo "-----"; \
   fdt set /chosen \\#size-cells <1>; \
   echo "-----"; \
   fdt set /chosen bootargs "${XEN_CMDLINE}"; \
   echo "-----"; \
   echo "---------------"; \
   fdt resize; \
   echo "-----"; \
   fdt mknod /chosen module@0; \
   echo "-----"; \
   fdt set /chosen/module@0 compatible "xen,linux-zimage" "xen,multiboot-module"; \
   echo "-----"; \
   fdt set /chosen/module@0 reg <${KERNEL_ADDRESS} ${KERNEL_SIZE}>; \
   echo "-----"; \
   fdt set /chosen/module@0 bootargs "${KERNEL_CMDLINE}"; \
   echo "-----"; \
   echo "---------------"; \
   fdt resize; \
   echo "-----"; \
   fdt mknod /chosen module@1; \
   echo "-----"; \
   fdt set /chosen/module@1 compatible "xen,linux-initrd" "xen,multiboot-module"; \
   echo "-----"; \
   fdt set /chosen/module@1 reg <${ROOTFS_ADDRESS} ${ROOTFS_SIZE}>; \
   echo "-----"; \
'

setenv test_dtb_chosen '
   fdt list /chosen
   fdt list /chosen/module@0
   fdt list /chosen/module@1
'

setenv boot_xen '
   booti ${XEN_ADDRESS} - ${DTB_ADDRESS}
'



setenv bootargs ${XEN_CMDLINE}

size virtio 0:1 xen
setenv XEN_SIZE 0x${filesize}
ext4load virtio 0:1 ${XEN_ADDRESS} xen

size virtio 0:1 kernel-dom0
setenv KERNEL_SIZE 0x${filesize}
ext4load virtio 0:1 ${KERNEL_ADDRESS} kernel-dom0

size virtio 0:1 rootfs-dom0
setenv ROOTFS_SIZE 0x${filesize}
ext4load virtio 0:1 ${ROOTFS_ADDRESS} rootfs-dom0

fdt addr -c
setenv DTB_ADDRESS ${fdtcontroladdr}

fdt addr ${DTB_ADDRESS}
