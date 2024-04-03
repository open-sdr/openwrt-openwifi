include $(TOPDIR)/rules.mk

PKG_NAME:=xilinx-vdma
PKG_RELEASE:=1

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/xilinx-vdma
	SUBMENU:=Wireless Drivers
	TITLE:=Driver for xilinx-vdma
	KCONFIG:=CONFIG_XILINX_DMA=m
	FILES:=$(LINUX_DIR)/drivers/dma/xilinx/xilinx_dma.ko
	AUTOLOAD:=$(call AutoLoad,103,xilinx_dma)
endef

define Build/Compile

endef

$(eval $(call KernelPackage,xilinx-vdma))
