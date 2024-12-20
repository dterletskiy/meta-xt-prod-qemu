setenv XEN_ADDRESS         0x50000000
setenv XEN_SIZE            0x0
setenv XEN_CMDLINE         "dom0_mem=3G,max:3G loglvl=all guest_loglvl=all console=dtuart"
setenv DTB_ADDRESS         0x51000000
setenv KERNEL_ADDRESS      0x60000000
setenv KERNEL_SIZE         0x0
setenv KERNEL_CMDLINE      "root=/dev/ram verbose loglevel=7 console=hvc0 earlyprintk=xen"
setenv ROOTFS_ADDRESS      0x52000000
setenv ROOTFS_SIZE         0x0



setenv load_xen '
   size virtio 0:1 xen
   setenv XEN_SIZE 0x${filesize}
   ext4load virtio 0:1 ${XEN_ADDRESS} xen
'

setenv load_kernel '
   size virtio 0:1 kernel-dom0
   setenv KERNEL_SIZE 0x${filesize}
   ext4load virtio 0:1 ${KERNEL_ADDRESS} kernel-dom0
'

setenv load_rootfs '
   size virtio 0:1 rootfs-dom0
   setenv ROOTFS_SIZE 0x${filesize}
   ext4load virtio 0:1 ${ROOTFS_ADDRESS} rootfs-dom0
'

setenv patch_dtb_chosen '
   echo "Patching node: /chosen"
   fdt resize
   fdt set /chosen \\#address-cells <1>
   fdt set /chosen \\#size-cells <1>
   fdt set /chosen bootargs "${XEN_CMDLINE}"

   echo "Patching node: /chosen/module@0"
   fdt resize
   fdt mknod /chosen module@0
   fdt set /chosen/module@0 compatible "xen,linux-zimage" "xen,multiboot-module"
   fdt set /chosen/module@0 reg <${KERNEL_ADDRESS} ${KERNEL_SIZE}>
   fdt set /chosen/module@0 bootargs "${KERNEL_CMDLINE}"
   echo "Patching node: /chosen/module@1"

   fdt resize
   fdt mknod /chosen module@1
   fdt set /chosen/module@1 compatible "xen,linux-initrd" "xen,multiboot-module"
   fdt set /chosen/module@1 reg <${ROOTFS_ADDRESS} ${ROOTFS_SIZE}>
'

setenv patch_dtb '
   echo "Setup dtb addresses"
   fdt addr -c
   setenv DTB_ADDRESS ${fdtcontroladdr}
   fdt addr ${DTB_ADDRESS}

   run patch_dtb_chosen
'

setenv test_dtb_chosen '
   fdt print /chosen
'

setenv boot_xen '
   booti ${XEN_ADDRESS} - ${DTB_ADDRESS}
'



setenv bootargs ${XEN_CMDLINE}

run load_xen
run load_kernel
run load_rootfs
run patch_dtb
