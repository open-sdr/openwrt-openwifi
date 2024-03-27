include $(TOPDIR)/rules.mk

PKG_NAME:=ad9361
PKG_RELEASE:=1

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

ADI_NAME:=adi_non-mainline_common/adi_linux
ADI_NON-MAINLINE_DIR:=$(PKG_BUILD_DIR)/../$(ADI_NAME)
subdir:=drivers/iio/adc

define KernelPackage/ad9361
	SUBMENU:=Industrial I/O Modules
	TITLE:=Analog Devices AD9361 ADC driver
	PROVIDES:=kmod-ad9361
	DEPENDS:=+kmod-adi_non-mainline_common \
			 +kmod-cf_axi_adc
	FILES:=$(ADI_NON-MAINLINE_DIR)/$(subdir)/ad9361_drv.ko
endef
	
# If OpenWiFi will be build, patches should be applied
OPENWIFI_REVISION:=061c9ffac699c79637f0c2b3904699a90bf38ab8
OPENWIFI_GITHUB_URL:=https://raw.githubusercontent.com/open-sdr/openwifi/$(OPENWIFI_REVISION)
define Build/Prepare
	cd $(ADI_NON-MAINLINE_DIR) && \
	wget $(OPENWIFI_GITHUB_URL)/kernel_boot/ad9361.patch && \
	wget $(OPENWIFI_GITHUB_URL)/kernel_boot/ad9361_conv.patch && \
	git apply ad9361.patch && \
	git apply ad9361_conv.patch
endef

NOSTDINC_FLAGS:=-DCONFIG_CF_AXI_ADC
CT_MAKEDEFS:= CONFIG_AD9361=m
define Build/Compile
	+$(KERNEL_MAKE) $(CT_MAKEDEFS) M=$(ADI_NON-MAINLINE_DIR)/$(subdir) NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
	cp $(ADI_NON-MAINLINE_DIR)/$(subdir)/Module.symvers $(PKG_BUILD_DIR)/Module.symvers
endef

$(eval $(call KernelPackage,ad9361))
