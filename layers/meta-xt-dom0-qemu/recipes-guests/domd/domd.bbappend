FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:remove += " \
    file://${XT_DOMD_CONFIG_NAME} \
"
