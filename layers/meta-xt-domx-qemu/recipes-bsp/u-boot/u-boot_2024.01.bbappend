FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://u-boot-fragment.cfg"

KCONFIG_FRAGMENTS += "u-boot-fragment.cfg"
