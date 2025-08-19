# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2015 OpenWrt.org

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

define Build/zynqmp-sdcard
	rm -f $@.boot
	mkfs.fat $@.boot -C $(FAT32_BLOCKS)
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.bin ::boot.bin
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot.img ::u-boot.img
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uEnv.txt ::uEnv.txt
	$(if $(CONFIG_ZYNQ_BITSTREAM_BOOTFS), \
		mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-system_top.bit ::system_top.bit \
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
	DEVICE_DTS := $(lastword $(subst _, ,$(1)))
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

define Device/xlnx_zynqmp-zcu102-rev1.0
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Xilinx
	DEVICE_MODEL := ZCU102 Rev1.0
endef
TARGET_DEVICES += xlnx_zynqmp-zcu102-rev1.0

$(eval $(call BuildImage))
