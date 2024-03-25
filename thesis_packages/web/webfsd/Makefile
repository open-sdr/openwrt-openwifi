include $(TOPDIR)/rules.mk
 
PKG_NAME:=webfsd
PKG_VERSION:=1.21
PKG_RELEASE:=1
 
PKG_SOURCE_URL:=https://github.com/ourway/webfsd.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=b92e187306ce73ba19d231ad28fe4a0f1b9668f6

PKG_MAINTAINER:=Robbe Gaeremynck <robbe.gaeremynck@outlook.com>

include $(INCLUDE_DIR)/package.mk
 
define Package/webfsd
	SECTION:=web
	CATEGORY:=Web
	TITLE:=A simple HTTP server for mostly static content written in C
	URL:=https://github.com/ourway/webfsd
endef

define Package/webfsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/webfsd $(1)/usr/bin

	$(INSTALL_DIR) $(1)/usr/local/share/man/man1
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/webfsd.man $(1)/usr/local/share/man/man1/webfsd.1
endef

$(eval $(call BuildPackage,webfsd))
