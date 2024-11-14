require recipes-core/images/core-image-minimal.bb

PACKAGE_INSTALL:append = " \
    coreutils \
    xen \
    xen-tools-scripts-network \
    xen-tools-scripts-block \
    xen-tools-xenstore \
    xen-tools-devd \
    xen-tools-pcid \
    virtual-xenstored \
    xen-network \
"

IMAGE_FSTYPES:remove = "wic.bz2 wic.bmap ext3"
IMAGE_FSTYPES:append = " ext4"
