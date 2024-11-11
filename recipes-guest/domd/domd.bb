SUMMARY = "Set of files to run a Driver domain"
DESCRIPTION = "A config file, kernel, dtb and scripts for a Driver domain"

PV = "0.1"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit externalsrc systemd

EXTERNALSRC_SYMLINKS = ""

FILESEXTRAPATHS:prepend := "${THISDIR}:"
SRC_URI = "\
    file://domd.service \
    file://domd.cfg \
"

FILES:${PN} = " \
    ${systemd_unitdir}/system/domd.service \
    ${sysconfdir}/xen/domd.cfg \
    ${libdir}/xen/boot/linux-domd \
"

DEPENDS += "virtual/kernel"
do_install[depends] += "virtual/kernel:do_deploy"


SYSTEMD_SERVICE:${PN} = "domd.service"

do_install() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/domd.service ${D}${systemd_unitdir}/system/

    install -d ${D}${sysconfdir}/xen
    install -m 0644 ${WORKDIR}/domd.cfg ${D}${sysconfdir}/xen/domd.cfg

    install -d ${D}${libdir}/xen/boot
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} ${D}${libdir}/xen/boot/linux-domd

    # install -d ${D}${libdir}/xen/boot
    # install -m 0644 ${S}/Image ${D}${libdir}/xen/boot/linux-domd
}

python() {
    bb.warn( "PN:                       " + d.getVar('PN', True) )
    bb.warn( "S:                        " + d.getVar('S', True) )
    bb.warn( "B:                        " + d.getVar('B', True) )
    bb.warn( "D:                        " + d.getVar('D', True) )
    bb.warn( "WORKDIR:                  " + d.getVar('WORKDIR', True) )
    bb.warn( "PKGD:                     " + d.getVar('PKGD', True) )
    bb.warn( "PKGDATA_DIR:              " + d.getVar('PKGDATA_DIR', True) )
    bb.warn( "DEPLOY_DIR:               " + d.getVar('DEPLOY_DIR', True) )
    bb.warn( "DEPLOY_DIR_IMAGE:         " + d.getVar('DEPLOY_DIR_IMAGE', True) )
    bb.warn( "STAGING_DIR_HOST:         " + d.getVar('STAGING_DIR_HOST', True) )
    bb.warn( "STAGING_DIR_TARGET:       " + d.getVar('STAGING_DIR_TARGET', True) )
    bb.warn( "STAGING_DIR_NATIVE:       " + d.getVar('STAGING_DIR_NATIVE', True) )
    bb.warn( "STAGING_INCDIR:           " + d.getVar('STAGING_INCDIR', True) )
    bb.warn( "STAGING_LIBDIR:           " + d.getVar('STAGING_LIBDIR', True) )
    bb.warn( "KERNEL_IMAGETYPE:         " + d.getVar('KERNEL_IMAGETYPE', True) )
    # bb.warn( "MODULE_TARBALL_DEPLOY:    " + d.getVar('MODULE_TARBALL_DEPLOY', True) )
}
