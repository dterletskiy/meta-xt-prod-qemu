ROOT_DIR=/mnt/host/epam/meta-xt-prod-qemu/
BUILD_DIR=${ROOT_DIR}/build/
YAML_FILE=prod-qemu.yaml

DOM0_DIR=build-dom0
DOM0_TARGET=core-image-thin-initramfs

DOMD_DIR=build-domd
DOMD_TARGET=qemu-image-minimal



# Make changes in "meta-xt-prod-qemu"
cd ${ROOT_DIR} && git status && git add . && git status && git commit -sm "update" && git push
cd ${BUILD_DIR}/yocto/meta-xt-prod-qemu && git pull



# Build
mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}

cd ${BUILD_DIR} && moulin ${ROOT_DIR}/${YAML_FILE}
cd ${BUILD_DIR} && ninja -v -d stats -d explain
cd ${BUILD_DIR} && rouge ${ROOT_DIR}/${YAML_FILE} -fi full -o full.img

# dom0 operations with ninja
ninja fetch-dom0
ninja conf-dom0
ninja dom0

# Build dom0 in yocto
cd ${BUILD_DIR}/yocto
source poky/oe-init-build-env ${DOM0_DIR}
bitbake ${DOM0_TARGET}

# Build domd in yocto
cd ${BUILD_DIR}/yocto
source poky/oe-init-build-env ${DOM0_DIR}
bitbake ${DOMD_TARGET}
