require xen-source.inc

do_deploy:append() {
    if [ -f ${B}/xen/xen-syms ]; then
        install -m 0644 ${B}/xen/xen-syms ${DEPLOYDIR}/xen-${MACHINE}-syms
    fi

    if [ -f ${B}/xen/xen-syms.map ]; then
        install -m 0644 ${B}/xen/xen-syms.map ${DEPLOYDIR}/xen-${MACHINE}-syms.map
    fi
}
