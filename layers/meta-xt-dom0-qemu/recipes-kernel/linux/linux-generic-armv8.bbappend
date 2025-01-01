FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://debug.cfg \
  "

KERNEL_CONFIG_FRAGMENTS += "debug.cfg"

do_deploy:append() {
    if [ -f ${B}/vmlinux ]; then
        cp ${B}/vmlinux ${DEPLOYDIR}/${PN}-vmlinux-${PV}-${PR}
    fi
}
