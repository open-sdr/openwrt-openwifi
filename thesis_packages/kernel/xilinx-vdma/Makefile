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
	PROVIDES:=kmod-xilinx-vdma
	FILES:=$(LINUX_DIR)/drivers/dma/xilinx/xilinx_dma.ko
endef

define Build/Compile

endef

$(eval $(call KernelPackage,xilinx-vdma))
