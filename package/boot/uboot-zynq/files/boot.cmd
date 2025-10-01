setenv devtype mmc
setenv bootpart 0:1

setenv bit_file openwifi_bitstream.bit
setenv bit_loadaddr 0x2000000

setenv kernel_file fit.itb
setenv kernel_loadaddr 0x1000000

setenv bootargs "console=ttyPS0,115200n8 root=/dev/mmcblk0p2 rootwait earlyprintk"

load ${devtype} ${bootpart} ${bit_loadaddr} ${bit_file}
fpga loadb 0 ${bit_loadaddr} ${filesize}
load ${devtype} ${bootpart} ${kernel_loadaddr} ${kernel_file}
bootm ${kernel_loadaddr}