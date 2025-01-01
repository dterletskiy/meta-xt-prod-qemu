FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://debug.cfg \
  "

KERNEL_CONFIG_FRAGMENTS += "debug.cfg"
