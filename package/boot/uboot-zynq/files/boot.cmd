setenv devtype mmc
setenv bootpart 0:1

setenv kernel_file fit.itb
setenv kernel_loadaddr 0x04000000

setenv bootargs "console=ttyPS0,115200n8 root=/dev/mmcblk0p2 rootwait earlyprintk"

load ${devtype} ${bootpart} ${kernel_loadaddr} ${kernel_file}
bootm ${kernel_loadaddr}