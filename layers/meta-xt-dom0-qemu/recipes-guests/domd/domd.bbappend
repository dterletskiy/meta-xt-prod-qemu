FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append() {
	sed -i 's/^After=proc-xen\.mount$/After=xendomains.service/' ${D}${systemd_unitdir}/system/domd.service
}
