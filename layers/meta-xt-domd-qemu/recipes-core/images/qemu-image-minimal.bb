require recipes-core/images/core-image-minimal.bb

PACKAGE_INSTALL:append = " \
    coreutils \
    xen \
    xen-tools-devd \
    xen-tools-scripts-network \
    xen-tools-scripts-block \
    xen-tools-xenstore \
    xen-network \
    virtual-xenstored \
"

IMAGE_FSTYPES:remove = "wic.bz2 wic.bmap ext3"
IMAGE_FSTYPES:append = " ext4"
