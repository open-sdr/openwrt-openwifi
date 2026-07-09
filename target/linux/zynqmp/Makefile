# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2015 OpenWrt.org

include $(TOPDIR)/rules.mk

ARCH:=aarch64
BOARD:=zynqmp
BOARDNAME:=Xilinx ZynqMP SoCs
FEATURES:=fpu gpio rtc usb usbgadget boot-part rootfs-part squashfs
CPU_TYPE:=cortex-a53
SUBTARGETS:=generic

define Target/Description
	Build firmware image for ZynqMP SoC devices.
endef

KERNEL_PATCHVER:=6.12

include $(INCLUDE_DIR)/target.mk

KERNELNAME:=Image dtbs

DEFAULT_PACKAGES += uboot-envtools mkf2fs e2fsprogs \
	kmod-usb-storage kmod-fs-msdos

$(eval $(call BuildTarget))
