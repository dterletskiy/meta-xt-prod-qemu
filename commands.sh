ROOT_DIR=/mnt/host/epam/meta-xt-prod-qemu/
BUILD_DIR=${ROOT_DIR}/build/



# Make changes in "meta-xt-prod-qemu"
cd ${ROOT_DIR} && git status && git add . && git status && git commit -sm "update" && git push
cd ${BUILD_DIR}/yocto/meta-xt-prod-qemu && git pull



# Build
mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}

cd ${BUILD_DIR} && moulin ${ROOT_DIR}/prod-qemu.yaml
cd ${BUILD_DIR} && ninja -v -d stats -d explain
cd ${BUILD_DIR} && rouge ${ROOT_DIR}/prod-qemu.yaml -fi full -o full.img

# dom0 operations with ninja
ninja fetch-dom0
ninja conf-dom0
ninja dom0

# Build dom0 in yocto
cd ${BUILD_DIR}/yocto
source poky/oe-init-build-env build-dom0
bitbake core-image-thin-initramfs

# Build domd in yocto
cd ${BUILD_DIR}/yocto
source poky/oe-init-build-env build-domd
bitbake qemu-image-minimal
