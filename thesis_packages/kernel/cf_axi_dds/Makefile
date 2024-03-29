include $(TOPDIR)/rules.mk

PKG_NAME:=cf_axi_dds
PKG_RELEASE:=1

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

ADI_VERSION:=adi-5.15
ADI_NAME:=adi_non-mainline_common
ADI_NON-MAINLINE_DIR:=$(BUILD_DIR)/$(ADI_NAME)-$(ADI_VERSION)
subdir:=drivers/iio/frequency

define KernelPackage/cf_axi_dds
	SUBMENU:=Industrial I/O Modules
	TITLE:=cf_axi_dds
	PROVIDES:=kmod-cf_axi_dds
	DEPENDS:=+adi_non-mainline_common
	FILES:=$(ADI_NON-MAINLINE_DIR)/$(subdir)/cf_axi_dds_drv.ko
	KCONFIG:=CONFIG_IIO_BUFFER_DMAENGINE=y
endef

CT_MAKEDEFS:= CONFIG_CF_AXI_DDS=m
define Build/Compile
	+$(KERNEL_MAKE) $(CT_MAKEDEFS) M=$(ADI_NON-MAINLINE_DIR)/$(subdir) NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
	cp $(ADI_NON-MAINLINE_DIR)/$(subdir)/Module.symvers $(PKG_BUILD_DIR)/Module.symvers
endef

$(eval $(call KernelPackage,cf_axi_dds))
