include $(TOPDIR)/rules.mk

PKG_NAME:=openwifi
PKG_RELEASE:=1

PKG_LICENSE:=AGPLv3
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

OPENWIFI_BRANCH:=thesis
OPENWIFI_REVISION:=5c5d825d # Latest known working commit
OPENWIFI_GITHUB_REPO:=https://username:password@development.tymeli.be/robbegaeremynck/openwifi.git
OPENWIFI_DIR:=$(PKG_BUILD_DIR)/$(PKG_NAME)

# Openwifi driver path
DRIVER_DIR:=$(OPENWIFI_DIR)/driver

# Directory to the adi_non-mainline_common dependency
ADI_VERSION:=thesis
ADI_NAME:=adi_non-mainline_common
ADI_NON-MAINLINE_DIR:=$(BUILD_DIR)/$(ADI_NAME)-$(ADI_VERSION)

# incl_fix_path fixes the include structure that is different
incl_fix_path:=$(ADI_NON-MAINLINE_DIR)/drivers/include_fix

define KernelPackage/openwifi
	SUBMENU:=Wireless Drivers
	TITLE:=Driver for openwifi
	DEPENDS:= \
		@TARGET_zynq \
		+kmod-mac80211 \
		+kmod-ad9361 \
		+kmod-cf_axi_dds \
		+wget-ssl \
		+kmod-xilinx-vdma \
		+hostapd \
		+webfsd \
		+uboot-envtools \
		+libnl \
		+libpcap
	FILES:=\
		$(DRIVER_DIR)/openofdm_tx/openofdm_tx.ko \
		$(DRIVER_DIR)/openofdm_rx/openofdm_rx.ko \
		$(DRIVER_DIR)/tx_intf/tx_intf.ko \
		$(DRIVER_DIR)/rx_intf/rx_intf.ko \
		$(DRIVER_DIR)/xpu/xpu.ko \
		$(DRIVER_DIR)/side_ch/side_ch.ko \
		$(DRIVER_DIR)/sdr.ko
	MENU:=1
endef

define Package/sdrctl
	SECTION:=tools
	CATEGORY:=Tools
	TITLE:=sdrctl tool for OpenWiFi
	DEPENDS:=kmod-openwifi +libnl
endef

define Package/inject_80211
	SECTION:=tools
	CATEGORY:=Tools
	TITLE:=inject80211 tool for OpenWiFi
	DEPENDS:=kmod-openwifi +libpcap
endef

define Package/side_ch_ctl
	SECTION:=tools
	CATEGORY:=Tools
	TITLE:=side_ch_ctl tool for OpenWiFi
	DEPENDS:=kmod-openwifi
endef


define KernelPackage/openwifi/config
	select PACKAGE_CFG80211_TESTMODE
	select ZYNQ_BITSTREAM_BOOTFS
	if PACKAGE_kmod-openwifi
		menu "OpenWiFi user space programs"
			config PACKAGE_side_ch_ctl
				bool "side_ch_ctl tool for OpenWiFi"
				default y
			config PACKAGE_inject_80211
				bool "inject_80211 tool for OpenWiFi"
				default y
			config PACKAGE_sdrctl
				bool "sdrctl tool for OpenWiFi"
				default y
		endmenu

		config PACKAGE_luci
			bool "(recommended) Use LuCi web interface"
			default y

		config OPENWIFI_DEFAULT_DTS
			bool "Let OpenWiFi choose the DTS file"
			default y
		if !OPENWIFI_DEFAULT_DTS
			config OPENWIFI_DTS_FILENAME
				string "DTS filename without .dts"
				default "devicetree"
			config OPENWIFI_DTS_FOLDER
				string "Enter DTS path"
				default "."
		endif

		config OPENWIFI_DEFAULT_BITSTREAM
			bool "Let OpenWiFi choose the bitstream"
			default y
		if !OPENWIFI_DEFAULT_BITSTREAM
			config OPENWIFI_BITSTREAM_FILE
				string "Path to bitstream"
				default "bitstreams/system_top.bit"
		endif
	endif
endef

CT_MAKEDEFS:=

# Include preprocessor definitions
BACKPORTS_VERSION := 5.15.92-1
NOSTDINC_FLAGS := \
	-I$(incl_fix_path) \
	-I$(KERNEL_BUILD_DIR)/backports-$(BACKPORTS_VERSION)/include \
	-include$(KERNEL_BUILD_DIR)/backports-$(BACKPORTS_VERSION)/backport-include/linux/version.h \
	-include$(KERNEL_BUILD_DIR)/backports-$(BACKPORTS_VERSION)/backport-include/linux/string.h \
	-include$(LINUX_DIR)/include/generated/autoconf.h \
	-include$(LINUX_DIR)/include/linux/kconfig.h \
	-include$(LINUX_DIR)/include/net/sock.h \
	-DCPTCFG_NL80211_TESTMODE

ifdef CONFIG_PACKAGE_MAC80211_DEBUGFS
	NOSTDINC_FLAGS += -DCPTCFG_MAC80211_DEBUGFS
endif

define Build/Prepare
	cd $(PKG_BUILD_DIR) && git clone --branch $(OPENWIFI_BRANCH) $(OPENWIFI_GITHUB_REPO) $(PKG_NAME)
	cd $(OPENWIFI_DIR) && git checkout $(OPENWIFI_REVISION)

	mkdir -p $(incl_fix_path)
	touch $(DRIVER_DIR)/pre_def.h
	cd $(DRIVER_DIR) && \
	echo "#define GIT_REV 0x$(OPENWIFI_REVISION)" > git_rev.h

	# Download the OpenWiFi webserver video
	cd $(OPENWIFI_DIR)/user_space/webserver && \
	wget https://github.com/open-sdr/openwifi-hw-img/raw/master/openwifi-low-aac.mp4
endef

ifneq ($(findstring c,$(OPENWRT_VERBOSE)),)
	CT_MAKEDEFS += V=1
endif

KBUILD_EXTRA_SYMBOLS:= \
	$(KERNEL_BUILD_DIR)/symvers/mac80211.symvers \
	$(KERNEL_BUILD_DIR)/symvers/adi_non-mainline_common.symvers

define Build/Compile/sdr
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)/openofdm_tx" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH) modules
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)/openofdm_rx" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH)  modules
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)/tx_intf" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH)  modules
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)/rx_intf" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH)  modules
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)/xpu" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH)  modules
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)/side_ch" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH) modules
	+$(MAKE) -C $(LINUX_DIR) M="$(DRIVER_DIR)" CROSS_COMPILE=$(TARGET_CROSS) ARCH=$(ARCH) KBUILD_EXTRA_SYMBOLS="$(KBUILD_EXTRA_SYMBOLS)" NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
	cp -f $(DRIVER_DIR)/Module.symvers $(PKG_BUILD_DIR)/Module.symvers
endef


SDRCTL_SRC_PATH:=user_space/sdrctl_src
define Build/Compile/sdrctl
	+$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(OPENWIFI_DIR)/$(SDRCTL_SRC_PATH) $(MAKE_FLAGS)
endef

INJECT_80211_SRC_PATH:=user_space/inject_80211
define Build/Compile/inject_80211
	+$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(OPENWIFI_DIR)/$(INJECT_80211_SRC_PATH) $(MAKE_FLAGS) INC_FLAGS="-I$(STAGING_DIR)/usr/include"
endef

SIDE_CH_CTL_SRC_PATH:=user_space/side_ch_ctl_src
define Build/Compile/side_ch_ctl
	+$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(OPENWIFI_DIR)/$(SIDE_CH_CTL_SRC_PATH) $(MAKE_FLAGS)
endef

# Compile the sdr + selected user space packages
user_space-$(CONFIG_PACKAGE_sdrctl)+= Build/Compile/sdrctl
user_space-$(CONFIG_PACKAGE_inject_80211)+= Build/Compile/inject_80211
user_space-$(CONFIG_PACKAGE_side_ch_ctl)+= Build/Compile/side_ch_ctl
define Build/Compile
	$(call Build/Compile/sdr)
	$(foreach cc,$(user_space-y), \
		$(newline)$(call $(cc)) \
	)
endef

# Install the uEnv to auto load the bitstream + OS
BOARD_NAME:=$(lastword $(subst -, ,$(PROFILE)))
BITSTREAM_PATH:=./files/bitstreams/$(BOARD_NAME)/$(BOARD_NAME)-v3.1.bit
ifdef !CONFIG_OPENWIFI_DEFAULT_BITSTREAM
	BITSTREAM_PATH:=OPENWIFI_BITSTREAM_FILE
endif

BUILD_DEVICE:=$(subst DEVICE_,,$(PROFILE))
define Build/InstallDev
	$(CP) -f ./files/uEnv-openwifi.txt $(STAGING_DIR_IMAGE)/$(BUILD_DEVICE)-uEnv.txt
	$(CP) -f $(BITSTREAM_PATH) $(STAGING_DIR_IMAGE)/$(BUILD_DEVICE)-system_top.bit
endef

# Copy the openwifi sources to the board, since user_space scripts necessary to play with the sdr
define KernelPackage/openwifi/install
	$(CP) $(OPENWIFI_DIR) $(1)/openwifi
	$(INSTALL_DATA) ./files/mime.types $(1)/openwifi/user_space/webserver

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/openwifi_service $(1)/etc/init.d/openwifi

	$(INSTALL_DIR) $(1)/etc/board.d
	$(INSTALL_DATA) ./files/openwifi_board $(1)/etc/board.d/01_openwifi
endef

define Package/sdrctl/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(OPENWIFI_DIR)/$(SDRCTL_SRC_PATH)/sdrctl $(1)/usr/bin
endef

define Package/inject_80211/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(OPENWIFI_DIR)/$(INJECT_80211_SRC_PATH)/inject_80211 $(1)/usr/bin
	$(INSTALL_BIN) $(OPENWIFI_DIR)/$(INJECT_80211_SRC_PATH)/analyze_80211 $(1)/usr/bin
endef

define Package/side_ch_ctl/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(OPENWIFI_DIR)/$(SIDE_CH_CTL_SRC_PATH)/side_ch_ctl $(1)/usr/bin
endef


$(eval $(call BuildPackage,sdrctl))
$(eval $(call BuildPackage,inject_80211))
$(eval $(call BuildPackage,side_ch_ctl))
$(eval $(call KernelPackage,openwifi))
