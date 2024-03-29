include $(TOPDIR)/rules.mk

PKG_NAME:=adi_non-mainline_common
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/analogdevicesinc/linux.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=adi-5.15.0
PKG_MIRROR_HASH:=95ca68ae13c0a6e514d36046cfe9218f

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

ADI_DIR:=$(PKG_BUILD_DIR)

define Package/adi_non-mainline_common
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=Provides ADI specific linux kernel source (Experimental)
	URL:=https://github.com/analogdevicesinc/linux
endef

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

define Build/Compile

endef

define Package/adi_non-mainline_common/install
	:
endef

$(eval $(call BuildPackage,adi_non-mainline_common))
