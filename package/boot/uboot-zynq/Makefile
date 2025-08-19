#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=2019.07

PKG_HASH:=bff4fa77e8da17521c030ca4c5b947a056c1b1be4d3e6ee8637020b8d50251d0

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define U-Boot/Default
  BUILD_TARGET:=zynq
  BUILD_SUBTARGET:=generic
  UBOOT_IMAGE:=spl/boot.bin u-boot.img
  UBOOT_CONFIG:=zynq_$(1)
  UENV:=default
  HIDDEN:=1
endef

define U-Boot/zc702
  NAME:=Xilinx ZC702 Dev Board
  BUILD_DEVICES:=xlnx_zynq-zc702
endef

define U-Boot/zc706
  NAME:=Xilinx ZC706 Dev Board
  BUILD_DEVICES:=xlnx_zynq-zc706
endef

define U-Boot/zed
  NAME:=Avnet Digilent ZedBoard Dev Board
  BUILD_DEVICES:=avnet_zynq-zed
endef

define U-Boot/zybo
  NAME:=Digilent Zybo Dev Board
  BUILD_DEVICES:=digilent_zynq-zybo
endef

define U-Boot/zybo_z7
  NAME:=Digilent Zybo Z7 board
  BUILD_DEVICES:=digilent_zynq-zybo-z7
endef

define U-Boot/adrv9361
  NAME :=Analog Devices adrv9361z7035
  BUILD_DEVICES:=analog_devices_zynq-adrv9361
endef

define U-Boot/adrv9364
  NAME :=Analog Devices adrv9364z7020
  BUILD_DEVICES:=analog_devices_zynq-adrv9364
endef

define U-Boot/antsdre200
  NAME :=MicroPhase AntSDR E200
  BUILD_DEVICES:=microphase_zynq-antsdre200
endef

define U-Boot/antsdre310
  NAME :=MicroPhase AntSDR E310
  BUILD_DEVICES:=microphase_zynq-antsdre310
endef

define U-Boot/antsdre310v2
  NAME :=MicroPhase AntSDR E310v2
  BUILD_DEVICES:=microphase_zynq-antsdre310v2
endef

define U-Boot/sdrpi
  NAME :=HexSDR SDRPi
  BUILD_DEVICES:=hexsdr_sdrpi
endef

define U-Boot/neptunesdr
  NAME :=HamGeek NeptuneSDR
  BUILD_DEVICES:=hamgeek_neptunesdr
endef

define U-Boot/pynq-z2
  NAME :=TUL PYNQ-Z2
  BUILD_DEVICES:=tul_zynq-pynq-z2
  UBOOT_CONFIG:=zynq_pynqz2
endef

UBOOT_TARGETS := \
	zc702 \
	zc706 \
	zed \
	zybo \
	zybo_z7 \
	adrv9361 \
	adrv9364 \
	antsdre200 \
	antsdre310 \
	antsdre310v2 \
	sdrpi \
	neptunesdr \
	pynq-z2


define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/spl/boot.bin $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-boot.bin
	$(CP) $(PKG_BUILD_DIR)/u-boot.img $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-u-boot.img
	$(CP) ./files/uEnv-$(UENV).txt $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-uEnv.txt
endef

define Package/u-boot/install/default
endef

$(eval $(call BuildPackage/U-Boot))
