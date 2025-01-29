FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SYSTEMD_AUTO_ENABLE = "disable"

do_install:append() {
   sed -i 's/^After=proc-xen\.mount$/After=xendomains.service/' ${D}${systemd_unitdir}/system/domd.service
}
