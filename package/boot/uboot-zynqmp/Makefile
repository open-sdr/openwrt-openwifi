#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=2025.01
PKG_HASH:=cdef7d507c93f1bbd9f015ea9bc21fa074268481405501945abc6f854d5b686f

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define U-Boot/Default
  BUILD_TARGET:=zynqmp
  BUILD_SUBTARGET:=generic
  UBOOT_IMAGE:=spl/boot.bin u-boot.img
  UBOOT_CONFIG:=xilinx_zynqmp_virt
  ATF:=zynqmp
  DEPENDS:= \
  	@TARGET_zynqmp \
  	+trusted-firmware-a-zynqmp \
  	+pmufw
  UENV:=default
  HIDDEN:=1
  DEPENDS+=+PACKAGE_kmod-openwifi:openwifi-hw-img
endef

define U-Boot/zcu102
  NAME:=Xilinx ZCU102 Rev1.1
  BUILD_DEVICES:=xlnx_zynqmp-zcu102
endef

UBOOT_TARGETS := \
	zcu102

UBOOT_CONFIGURE_VARS := DEVICE_TREE="zynqmp-zcu102-rev1.1"

UBOOT_MAKE_FLAGS += \
	BL31=$(STAGING_DIR_IMAGE)/bl31_zynqmp.bin \
	DEVICE_TREE="zynqmp-zcu102-rev1.1"

# Generate pm_cfg_obj.bin
# TODO: remove the hardcode of zcu102 in path to pm_cfg_obj.c
define Build/Configure
	$(call Build/Configure/U-Boot)
	$(PKG_BUILD_DIR)/scripts/config --file $(PKG_BUILD_DIR)/.config --disable TOOLS_MKEFICAPSULE
	$(PKG_BUILD_DIR)/scripts/config --file $(PKG_BUILD_DIR)/.config --set-str CONFIG_PMUFW_INIT_FILE $(STAGING_DIR_IMAGE)/pmufw.bin
	$(PKG_BUILD_DIR)/scripts/config --file $(PKG_BUILD_DIR)/.config --set-str CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE $(STAGING_DIR_IMAGE)/pm_cfg_obj.bin
	$(PKG_BUILD_DIR)/scripts/config --file $(PKG_BUILD_DIR)/.config --set-str CONFIG_XILINX_PS_INIT_FILE $(STAGING_DIR)/openwifi-hw-img/psu_init_gpl.c
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) $(UBOOT_CONFIGURE_VARS) oldconfig

	mkdir -p $(STAGING_DIR_IMAGE)
	python3 $(PKG_BUILD_DIR)/tools/zynqmp_pm_cfg_obj_convert.py "./files/zcu102/pm_cfg_obj.c" "$(STAGING_DIR_IMAGE)/pm_cfg_obj.bin"
endef


define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/spl/boot.bin $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-boot.bin
	$(CP) $(PKG_BUILD_DIR)/u-boot.itb $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-u-boot.itb

	# Install boot command
	$(CP) ./files/boot.cmd $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-boot.cmd
endef

define Package/u-boot/install/default
endef

$(eval $(call BuildPackage/U-Boot))
