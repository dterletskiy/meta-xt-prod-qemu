FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://debug.cfg \
    file://early_printk_kvmtool.cfg \
    "

DEPENDS += "u-boot-mkimage-native"

do_deploy:append() {
    if [ -f ${B}/xen/xen-syms ]; then
        install -m 0644 ${B}/xen/xen-syms ${DEPLOYDIR}/xen-${MACHINE}-syms
    fi

    if [ -f ${B}/xen/xen-syms.map ]; then
        install -m 0644 ${B}/xen/xen-syms.map ${DEPLOYDIR}/xen-${MACHINE}-syms.map
    fi

    if [ -f ${DEPLOYDIR}/xen-${MACHINE} ]; then
        uboot-mkimage -A arm64 -C none -T kernel -a 0x78080000 -e 0x78080000 -n "XEN" -d ${DEPLOYDIR}/xen-${MACHINE} ${DEPLOYDIR}/xen-${MACHINE}.uImage
        ln -sfr ${DEPLOYDIR}/xen-${MACHINE}.uImage ${DEPLOYDIR}/xen-${MACHINE}-uImage
    fi
}
