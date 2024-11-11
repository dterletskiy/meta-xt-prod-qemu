# SRCREV = "01f0d2de86f58b035f550fb0291741d1eba6dc8f"
SRCREV = "${AUTOREV}"

XEN_REL = "4.19-xt-v4-demo-smmu-fix"
XEN_BRANCH = "4.19-xt-v4-demo-smmu-fix"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI = "\
    git://github.com/lorc/xen.git;branch=${XEN_BRANCH};protocol=https \
    file://defconfig \
"
