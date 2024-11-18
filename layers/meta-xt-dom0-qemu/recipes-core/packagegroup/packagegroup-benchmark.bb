DESCRIPTION = "XEN"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} = " \
   sysbench \
   stress-ng \
   memtester \
   fio \
   hdparm \
   phoronix-test-suite \
   lmbench \
"
