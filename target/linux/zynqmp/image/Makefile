# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2015 OpenWrt.org

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

ifdef CONFIG_PACKAGE_kmod-openwifi
	CONFIG_TARGET_KERNEL_PARTSIZE:=64
endif

define Build/zynqmp-sdcard
	# Compile boot command
	mkimage -A arm -T script -C none -d $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.cmd $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.scr

	rm -f $@.boot
	mkfs.fat $@.boot -C $(FAT32_BLOCKS)
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.bin ::boot.bin
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot.itb ::u-boot.itb
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.scr ::boot.scr
	$(if $(CONFIG_ZYNQMP_BITSTREAM_BOOTFS), \
		mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-system_top.bit ::bitstream.bit \
		,)
	$(if $(CONFIG_HAS_OVERLAYS_BOOTFS), \
		mcopy -i $@.boot $(STAGING_DIR_IMAGE)/overlays ::overlays \
		,)
	mcopy -i $@.boot $(IMAGE_KERNEL) ::fit.itb
	./gen_zynqmp_sdcard_img.sh $@ \
		$@.boot \
		$(IMAGE_ROOTFS) \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE)
	rm -f $@.boot
endef

#################################################
# Default and templates
#################################################

define Device/Default
	PROFILES := Default
	DEVICE_DTC_FLAGS := -@
	DEVICE_DTS := $(lastword $(subst _, ,$(1)))
	DTS_DIR := $(DTS_DIR)/xilinx
	KERNEL_DEPENDS = $$(wildcard $(DTS_DIR)/$$(DEVICE_DTS).dts)
	KERNEL_LOADADDR := 0x8000
	IMAGES := sdcard.img.gz
	IMAGE/sdcard.img.gz := zynqmp-sdcard | gzip
endef

define Device/FitImageGzip
	KERNEL_SUFFIX := -fit-uImage.itb
	KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

#################################################
# Devices
#################################################

define Device/xlnx_zynqmp-zcu102
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Xilinx
	DEVICE_MODEL := ZCU102 Rev1.1
	DEVICE_DTS := zynqmp-zcu102-rev1.1
endef
TARGET_DEVICES += xlnx_zynqmp-zcu102

$(eval $(call BuildImage))
