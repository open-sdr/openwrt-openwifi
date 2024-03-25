include $(TOPDIR)/rules.mk

PKG_NAME:=adi_non-mainline_common
PKG_RELEASE:=1

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

REPO_NAME:=adi_linux
GIT_REPO:=https://github.com/analogdevicesinc/linux.git
GIT_BRANCH:=adi-5.15.0

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

WGET_URL:=https://raw.githubusercontent.com/analogdevicesinc/linux/$(GIT_BRANCH)
ADI_DIR:=$(PKG_BUILD_DIR)/$(REPO_NAME)

define KernelPackage/adi_non-mainline_common
	SUBMENU:=Wireless Drivers
	TITLE:=Enables support for non mainline analog devices drivers (Experimental)
	PROVIDES:=kmod-adi_non-mainline_common
endef
	
# Build with remote sources
# define Build/Prepare
# 	$(if $(wildcard $(ADI_DIR)), ,cd $(PKG_BUILD_DIR) && git clone --branch $(GIT_BRANCH) $(GIT_REPO) $(REPO_NAME))
# endef

#Build with local sources
# OUTPUT MUST BE SET
define Build/Prepare
	rm -rf $(ADI_DIR)
	cp -rf /workdir/adi_linux $(ADI_DIR)

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
# cp -f $(ADI_DIR)/include/linux/iio/buffer_impl.h $(LINUX_DIR)/include/linux/iio/buffer_impl.h
# cp -f $(ADI_DIR)/include/linux/iio/buffer-dma.h $(LINUX_DIR)/include/linux/iio/buffer-dma.h
# cp -f $(ADI_DIR)/include/linux/iio/buffer-dmaengine.h $(LINUX_DIR)/include/linux/iio/buffer-dmaengine.h
# cp -f $(ADI_DIR)/include/linux/iio/iio.h $(LINUX_DIR)/include/linux/iio/iio.h

#

# 
# cp -f $(ADI_DIR)/drivers/iio/industrialio-core.c $(LINUX_DIR)/drivers/iio/industrialio-core.c
# cp -f $(ADI_DIR)/include/uapi/linux/iio/types.h $(LINUX_DIR)/include/uapi/linux/iio/types.h
# define Build/Prepare
# 	rm -rf $(PKG_BUILD_DIR)/adi_linux
# 	cp -r /workdir/adi_linux $(PKG_BUILD_DIR)/adi_linux
# 	cp -n -r $(ADI_DIR)/include/* $(LINUX_DIR)/include/*
# endef
# cp $(ADI_DIR)/include/linux/iio/buffer_impl.h $(LINUX_DIR)/include/linux/iio/buffer_impl.h

define Build/Compile

endef

$(eval $(call KernelPackage,adi_non-mainline_common))
