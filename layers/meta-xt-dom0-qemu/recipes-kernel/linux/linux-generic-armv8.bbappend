FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://debug.cfg \
  "

KBUILD_DEFCONFIG = "debug.cfg"
