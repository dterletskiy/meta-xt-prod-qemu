setenv bootargs console=ttyAMA0,115200 root=/dev/mmcblk0p2 rw
load mmc 0:1 0x80000000 /boot/uImage
bootm 0x80000000
