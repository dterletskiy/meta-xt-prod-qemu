DESCRIPTION = "XEN"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} = " \
   domd \
   kernel-module-xen-pciback \
"
