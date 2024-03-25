include $(TOPDIR)/rules.mk

PKG_NAME:=cf_axi_dds
PKG_RELEASE:=1

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

ADI_NAME:=adi_non-mainline_common/adi_linux
ADI_NON-MAINLINE_DIR:=$(PKG_BUILD_DIR)/../$(ADI_NAME)
subdir:=drivers/iio/frequency

define KernelPackage/cf_axi_dds
	SUBMENU:=Wireless Drivers
	TITLE:=Enables support for non mainline analog devices drivers (Experimental)
	PROVIDES:=kmod-cf_axi_dds
	DEPENDS:=+kmod-adi_non-mainline_common
	FILES:=$(ADI_NON-MAINLINE_DIR)/$(subdir)/cf_axi_dds_drv.ko
	KCONFIG:=CONFIG_IIO_BUFFER_DMAENGINE=y
endef

define Build/Prepare

endef

CT_MAKEDEFS:= CONFIG_CF_AXI_DDS=m
define Build/Compile
	+$(KERNEL_MAKE) $(CT_MAKEDEFS) M=$(ADI_NON-MAINLINE_DIR)/$(subdir) NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
	cp $(ADI_NON-MAINLINE_DIR)/$(subdir)/Module.symvers $(PKG_BUILD_DIR)/Module.symvers
endef

$(eval $(call KernelPackage,cf_axi_dds))
