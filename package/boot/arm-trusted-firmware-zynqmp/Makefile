#
# Copyright (C) 2025 Robbe Gaeremynck
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=2.13
PKG_RELEASE:=1

# At the time of adding, DL link of parent package in OpenWrt 23.05 isn't working anymore
# Already fixed in newer OpenWrt versions
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_HASH:=92cc04fc8f57d904c84c2de583d376c9a95f89bec4a961e20df7dc4df2321f56

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=license.md

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/trusted-firmware-a.mk
include $(INCLUDE_DIR)/package.mk

define Trusted-Firmware-A/Default
	BUILD_TARGET:=zynqmp
	BUILD_SUBTARGET:=generic
endef

define Trusted-Firmware-A/zynqmp
	NAME:=ZynqMP
	PLAT:=zynqmp
endef
#	TFA_MAKE_FLAGS+=cadence0

TFA_TARGETS:= \
	zynqmp

define Package/trusted-firmware-a/install
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/build/$(PLAT)/release/bl31.bin $(STAGING_DIR_IMAGE)/bl31_$(BUILD_VARIANT).bin
endef

$(eval $(call BuildPackage/Trusted-Firmware-A))
