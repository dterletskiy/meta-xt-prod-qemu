FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://defconfig.cfg \
  "

KBUILD_DEFCONFIG = "defconfig.cfg"
