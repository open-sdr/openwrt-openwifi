include $(TOPDIR)/rules.mk

PKG_NAME:=adi_non-mainline_common
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://username:password@development.tymeli.be/robbegaeremynck/linux.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=thesis
PKG_MIRROR_HASH:=346c39a89098b136c4ec25ac9a15f15776bedcd064b34b5173fc0a2f6321245b

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

ADI_DIR:=$(PKG_BUILD_DIR)

OPENWIFI_REVISION:=061c9ffac699c79637f0c2b3904699a90bf38ab8
OPENWIFI_GITHUB_URL:=https://raw.githubusercontent.com/open-sdr/openwifi/$(OPENWIFI_REVISION)

define Build/Configure
	cp -f $(ADI_DIR)/include/linux/clk/clkscale.h $(LINUX_DIR)/include/linux/clk/clkscale.h

	mkdir -p $(LINUX_DIR)/include/linux/jesd204
	cp -f $(ADI_DIR)/include/linux/jesd204/jesd204.h $(LINUX_DIR)/include/linux/jesd204/jesd204.h
	cp -f $(ADI_DIR)/include/linux/jesd204/adi-common.h $(LINUX_DIR)/include/linux/jesd204/adi-common.h

	mkdir -p $(LINUX_DIR)/include/linux/iio
	cp -f $(ADI_DIR)/include/linux/iio/types.h $(LINUX_DIR)/include/linux/iio/types.h
	cp -f $(ADI_DIR)/include/linux/iio/iio.h $(LINUX_DIR)/include/linux/iio/iio.h
	cp -f $(ADI_DIR)/include/linux/iio/buffer_impl.h $(LINUX_DIR)/include/linux/iio/buffer_impl.h
	cp -f $(ADI_DIR)/include/linux/iio/buffer-dma.h $(LINUX_DIR)/include/linux/iio/buffer-dma.h
	cp -f $(ADI_DIR)/include/linux/iio/buffer-dmaengine.h $(LINUX_DIR)/include/linux/iio/buffer-dmaengine.h

	mkdir -p $(LINUX_DIR)/include/dt-bindings/jesd204
	cp -f $(ADI_DIR)/include/dt-bindings/jesd204/device-states.h $(LINUX_DIR)/include/dt-bindings/jesd204/device-states.h

	mkdir -p $(LINUX_DIR)/include/linux/fpga
	cp -f $(ADI_DIR)/include/linux/fpga/adi-axi-common.h $(LINUX_DIR)/include/linux/fpga/adi-axi-common.h

	mkdir -p $(LINUX_DIR)/drivers/iio
	cp -f $(ADI_DIR)/drivers/iio/industrialio-core.c $(LINUX_DIR)/drivers/iio/industrialio-core.c
	cp -f $(ADI_DIR)/drivers/iio/industrialio-buffer.c $(LINUX_DIR)/drivers/iio/industrialio-buffer.c
	cp -f $(ADI_DIR)/drivers/iio/buffer/industrialio-buffer-dmaengine.c $(LINUX_DIR)/drivers/iio/buffer/industrialio-buffer-dmaengine.c
	cp -f $(ADI_DIR)/drivers/iio/buffer/industrialio-buffer-dma.c $(LINUX_DIR)/drivers/iio/buffer/industrialio-buffer-dma.c
	cp -f $(ADI_DIR)/drivers/iio/iio_core.h $(LINUX_DIR)/drivers/iio/iio_core.h

	mkdir -p $(LINUX_DIR)/include/uapi/linux/iio
	cp -f $(ADI_DIR)/include/uapi/linux/iio/types.h $(LINUX_DIR)/include/uapi/linux/iio/types.h
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(call Build/ad9361/Prepare)
endef

# --- IIO/ADC DRIVERS
iio_adc_subdir:=drivers/iio/adc
PKG_EXTMOD_SUBDIRS += $(iio_adc_subdir)
#
#	AD9361 ADC driver
#
define KernelPackage/ad9361
	SUBMENU:=Industrial I/O Modules
	TITLE:=Analog Devices AD9361 ADC driver
	DEPENDS:=+kmod-cf_axi_adc +kmod-cf_axi_dds
	FILES:=$(ADI_DIR)/$(iio_adc_subdir)/ad9361_drv.ko
endef
adi-$(CONFIG_PACKAGE_kmod-ad9361)+= CONFIG_AD9361=m
NOSTDINC_FLAGS-$(CONFIG_PACKAGE_kmod-ad9361)+=-DCONFIG_CF_AXI_ADC

# If OpenWiFi will be build, patches should be applied
define Build/ad9361/Prepare
	cd $(ADI_DIR) && \
	wget $(OPENWIFI_GITHUB_URL)/kernel_boot/ad9361.patch && \
	wget $(OPENWIFI_GITHUB_URL)/kernel_boot/ad9361_conv.patch && \
	git apply ad9361.patch && \
	git apply ad9361_conv.patch
endef

#
#	CF_AXI_ADC driver
#
define KernelPackage/cf_axi_adc
	SUBMENU:=Industrial I/O Modules
	TITLE:=cf_axi_adc
	FILES:=$(ADI_DIR)/$(iio_adc_subdir)/cf_axi_adc.ko
	KCONFIG:=CONFIG_IIO_BUFFER_DMAENGINE=y
endef
adi-$(CONFIG_PACKAGE_kmod-cf_axi_adc)+= CONFIG_CF_AXI_ADC=m

# --- IIO/FREQUENCY DRIVERS
iio_frequency_subdir:=drivers/iio/frequency
PKG_EXTMOD_SUBDIRS += $(iio_frequency_subdir)
#
#	CF_AXI_DDS driver
#
define KernelPackage/cf_axi_dds
	SUBMENU:=Industrial I/O Modules
	TITLE:=cf_axi_dds
	FILES:=$(ADI_DIR)/$(iio_frequency_subdir)/cf_axi_dds_drv.ko
	KCONFIG:=CONFIG_IIO_BUFFER_DMAENGINE=y
endef
adi-$(CONFIG_PACKAGE_kmod-cf_axi_dds)+= CONFIG_CF_AXI_DDS=m

CT_MAKEDEFS:=$(adi-y)
NOSTDINC_FLAGS:=$(NOSTDINC_FLAGS-y)
define Build/Compile
	+$(KERNEL_MAKE) $(CT_MAKEDEFS) M=$(ADI_DIR)/$(iio_adc_subdir) NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
	+$(KERNEL_MAKE) $(CT_MAKEDEFS) M=$(ADI_DIR)/$(iio_frequency_subdir) NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
endef

$(eval $(call KernelPackage,ad9361))
$(eval $(call KernelPackage,cf_axi_adc))
$(eval $(call KernelPackage,cf_axi_dds))
