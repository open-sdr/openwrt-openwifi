include $(TOPDIR)/rules.mk

PKG_NAME:=cf_axi_adc
PKG_RELEASE:=1

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

ADI_NAME:=adi_non-mainline_common/adi_linux
ADI_NON-MAINLINE_DIR:=$(PKG_BUILD_DIR)/../$(ADI_NAME)
subdir:=drivers/iio/adc

define KernelPackage/cf_axi_adc
	SUBMENU:=Industrial I/O Modules
	TITLE:=cf_axi_adc
	PROVIDES:=kmod-cf_axi_adc
	DEPENDS:=+kmod-adi_non-mainline_common
	FILES:=$(ADI_NON-MAINLINE_DIR)/$(subdir)/cf_axi_adc.ko
	KCONFIG:=CONFIG_IIO_BUFFER_DMAENGINE=y
endef

CT_MAKEDEFS:= CONFIG_CF_AXI_ADC=m
define Build/Compile
	+$(KERNEL_MAKE) $(CT_MAKEDEFS) M=$(ADI_NON-MAINLINE_DIR)/$(subdir) modules
	cp $(ADI_NON-MAINLINE_DIR)/$(subdir)/Module.symvers $(PKG_BUILD_DIR)/Module.symvers
endef

$(eval $(call KernelPackage,cf_axi_adc))
