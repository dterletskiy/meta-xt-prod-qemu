require recipes-core/images/core-image-minimal.bb

DEPENDS += "u-boot"

PACKAGE_INSTALL:append = " \
    coreutils \
    xen \
    xen-tools-devd \
    xen-tools-scripts-network \
    xen-tools-scripts-block \
    xen-tools-xenstore \
    xen-network \
    virtual-xenstored \
    u-boot \
"

IMAGE_FSTYPES:remove = "wic.bz2 wic.bmap ext3"
IMAGE_FSTYPES:append = " ext4"
