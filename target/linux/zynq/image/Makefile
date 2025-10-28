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
	# Compile boot command
	mkimage -A arm -T script -C none -d $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.cmd $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.scr

	rm -f $@.boot
	mkfs.fat $@.boot -C $(FAT32_BLOCKS)
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.bin ::boot.bin
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot.img ::u-boot.img
	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.scr ::boot.scr
	$(if $(CONFIG_ZYNQ_BITSTREAM_BOOTFS), \
		mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-system_top.bit ::bitstream.bit \
		,)
	$(if $(CONFIG_HAS_OVERLAYS_BOOTFS), \
		mcopy -i $@.boot $(STAGING_DIR_IMAGE)/overlays ::overlays \
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
	DEVICE_DTC_FLAGS := -@
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

define Device/xlnx_zynq-zc706
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Xilinx
	DEVICE_MODEL := ZC706
endef
TARGET_DEVICES += xlnx_zynq-zc706


# TODO: Include the zynq-7000.dtsi from the kernel, not the one that we provide
# DTS_CPPFLAGS for this is already provided, only need to uncomment and remove ./dts/include folder
# Reason for this fix is, that qspi node is missing in older kernel, see Linux kernel commit 2902c0c

define Device/analog_devices_zynq-adrv9361
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Analog Devices
	DEVICE_MODEL := adrv9361z7035
	DTS_DIR := ../dts
#	DTS_CPPFLAGS := -I$(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts
endef
TARGET_DEVICES += analog_devices_zynq-adrv9361

# For now, we assume only bob, no fmc
define Device/analog_devices_zynq-adrv9364
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := Analog Devices
	DEVICE_MODEL := adrv9364z7020
	DTS_DIR := ../dts
#	DTS_CPPFLAGS := -I$(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts
endef
TARGET_DEVICES += analog_devices_zynq-adrv9364

define Device/microphase_zynq-antsdre200
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := MicroPhase
	DEVICE_MODEL := AntSDR E200
#	DTS_CPPFLAGS := -I$(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts
endef
TARGET_DEVICES += microphase_zynq-antsdre200

define Device/microphase_zynq-antsdre310
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := MicroPhase
	DEVICE_MODEL := AntSDR E310
#	DTS_CPPFLAGS := -I$(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts
endef
TARGET_DEVICES += microphase_zynq-antsdre310

define Device/microphase_zynq-antsdre310v2
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := MicroPhase
	DEVICE_MODEL := AntSDR E310v2
#	DTS_CPPFLAGS := -I$(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts
endef
TARGET_DEVICES += microphase_zynq-antsdre310v2

#define Device/hexsdr_sdrpi
#	$(call Device/FitImageGzip)
#	DEVICE_VENDOR := HexSDR
#	DEVICE_MODEL := SDRPi
#endef
#TARGET_DEVICES += hexsdr_sdrpi
#
#define Device/hamgeek_neptunesdr
#	$(call Device/FitImageGzip)
#	DEVICE_VENDOR := HamGeek
#	DEVICE_MODEL := NeptuneSDR
#endef
#TARGET_DEVICES += hamgeek_neptunesdr

define Device/tul_zynq-pynq-z2
	$(call Device/FitImageGzip)
	DEVICE_VENDOR := TUL
	DEVICE_MODEL := PYNQ-Z2
	DTS_DIR := ../dts
endef
TARGET_DEVICES += tul_zynq-pynq-z2



$(eval $(call BuildImage))
