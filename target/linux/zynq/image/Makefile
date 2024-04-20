# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2015 OpenWrt.org

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

ifdef CONFIG_PACKAGE_kmod-openwifi
	CONFIG_TARGET_KERNEL_PARTSIZE:=32
endif

define Build/zynq-sdcard
	rm -f $@.boot
	mkfs.fat $@.boot -C $(FAT32_BLOCKS)
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.bin ::boot.bin
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot.img ::u-boot.img
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uEnv.txt ::uEnv.txt
	$(if $(CONFIG_ZYNQ_BITSTREAM_BOOTFS), \
		mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-system_top.bit ::system_top.bit \
		,)
	mcopy -i $@.boot $(IMAGE_KERNEL) ::fit.itb
	./gen_zynq_sdcard_img.sh $@ \
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
	DTS_DIR := $(DTS_DIR)/xilinx
	DEVICE_DTS := $(lastword $(subst _, ,$(1)))
	KERNEL_DEPENDS = $$(wildcard $(DTS_DIR)/$$(DEVICE_DTS).dts)
	KERNEL_LOADADDR := 0x8000
	IMAGES := sdcard.img.gz
	IMAGE/sdcard.img.gz := zynq-sdcard | gzip
endef

define Device/FitImageGzip
	KERNEL_SUFFIX := -fit-uImage.itb
	KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

#################################################
# Package specific DTS
#################################################

# Use the DTS file provided by OpenWiFi
define Setup/OpenWiFi
	ifeq ($(CONFIG_PACKAGE_kmod-openwifi),y)
		ifeq ($(CONFIG_OPENWIFI_DEFAULT_DTS),y)
			DEVICE_DTS := devicetree
			DTS_DIR := $(PKG_BUILD_DIR)/openwifi/openwifi/kernel_boot/boards/$$(DEVICE_MODEL)
		else
			DEVICE_DTS := $(CONFIG_OPENWIFI_DTS_FILENAME)
			DTS_DIR := $(CONFIG_OPENWIFI_DTS_FOLDER)
		endif
	endif
endef

#################################################
# Devices
#################################################

define Device/avnet_zynq-zed
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Avnet
	DEVICE_MODEL := ZedBoard
endef
TARGET_DEVICES += avnet_zynq-zed

define Device/digilent_zynq-zybo
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Digilent
	DEVICE_MODEL := Zybo
endef
TARGET_DEVICES += digilent_zynq-zybo

define Device/digilent_zynq-zybo-z7
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Digilent
	DEVICE_MODEL := Zybo Z7
endef
TARGET_DEVICES += digilent_zynq-zybo-z7

define Device/xlnx_zynq-zc702
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Xilinx
	DEVICE_MODEL := ZC702
	DEVICE_PACKAGES:=kmod-can kmod-can-xilinx-can
endef
TARGET_DEVICES += xlnx_zynq-zc702

define Device/analog_devices_zynq-adrv9361
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Analog Devices
	DEVICE_MODEL := adrv9361z7035
	DTS_DIR := ../dts
	$(Setup/OpenWiFi)
endef
TARGET_DEVICES += analog_devices_zynq-adrv9361

define Device/tul_zynq-pynq-z2
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := TUL
	DEVICE_MODEL := PYNQ-Z2
	DTS_DIR := ../dts
endef
TARGET_DEVICES += tul_zynq-pynq-z2



$(eval $(call BuildImage))
