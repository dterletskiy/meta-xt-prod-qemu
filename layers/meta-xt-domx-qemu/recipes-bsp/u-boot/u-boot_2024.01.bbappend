FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://u-boot-fragment.cfg \
            boot.cmd \
"

KCONFIG_FRAGMENTS += "u-boot-fragment.cfg"

DEPENDS += "u-boot-mkimage-native"

do_deploy:append() {
    boot_cmd="${WORKDIR}/boot.cmd"
    boot_scr="${DEPLOYDIR}/boot.scr"

    if [ ! -f "${boot_cmd}" ]; then
       uboot-mkimage -A arm64 -T script -C none -n "Boot script" -d "${boot_cmd}" "${boot_scr}"
    fi

}
