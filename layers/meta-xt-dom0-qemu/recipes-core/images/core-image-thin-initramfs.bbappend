INITRAMFS_MAXSIZE = "1048576"

IMAGE_INSTALL:remove = " \
   ${XT_GUEST_INSTALL} \
   xen-tools \
"

IMAGE_INSTALL:append = " \
   packagegroup-benchmark \
"
