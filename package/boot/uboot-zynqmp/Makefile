#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=2025.07
PKG_HASH:=0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define U-Boot/Default
  BUILD_TARGET:=zynqmp
  BUILD_SUBTARGET:=armv8
  UBOOT_IMAGE:=spl/boot.bin u-boot.img
  UBOOT_CONFIG:=xilinx_zynqmp_virt
  DEVICE_TREE:=zynqmp-$(1)
  ATF:=zynqmp
  DEPENDS:=+PACKAGE_u-boot-zynqmp_zcu102-rev1.1:trusted-firmware-a-zynqmp
  UENV:=default
  HIDDEN:=1
endef

define U-Boot/zcu102-rev1.1
  NAME:=Xilinx ZCU102 Rev1.1
  BUILD_DEVICES:=xlnx_zynqmp-zcu102-rev1.1
endef

UBOOT_TARGETS := \
	zcu102-rev1.1

UBOOT_CUSTOMIZE_CONFIG := \
	--disable TOOLS_MKEFICAPSULE ; \
	setval CONFIG_PMUFW_INIT_FILE "$(STAGING_DIR_IMAGE)/pmufw.bin" ; \
	setval CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE "$(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-pm_cfg_obj.bin"

UBOOT_MAKE_FLAGS += \
	BL31=$(STAGING_DIR_IMAGE)/bl31_zynqmp-$(ATF).bin

# Generate pm_cfg_obj.bin
# TODO: remove the hardcode of zcu102 in path to pm_cfg_obj.c
define Build/Configure
	$(call Build/Configure/U-Boot)
	python3 $(PKG_BUILD_DIR)/tools/zynqmp_pm_cfg_obj_convert.py "./files/zcu102/pm_cfg_obj.c" "$(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-pm_cfg_obj.bin"
endef


define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/spl/boot.bin $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-boot.bin
	$(CP) $(PKG_BUILD_DIR)/u-boot.itb $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-u-boot.itb
	$(CP) ./files/uEnv-$(UENV).txt $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-uEnv.txt
endef

define Package/u-boot/install/default
endef

$(eval $(call BuildPackage/U-Boot))
