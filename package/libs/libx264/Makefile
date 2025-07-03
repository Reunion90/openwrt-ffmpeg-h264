include $(TOPDIR)/rules.mk

PKG_NAME:=libx264
PKG_VERSION:=20240513
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://code.videolan.org/videolan/x264.git
PKG_SOURCE_VERSION:=31e19f92f00c7003fa115047ce50978bc98c3a0d
PKG_MIRROR_HASH:=skip

PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libx264
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Multimedia
  DEPENDS:=+libpthread
  TITLE:=H.264/AVC encoder library
  URL:=https://www.videolan.org/developers/x264.html
endef

define Package/libx264/description
  x264 is a free software library for encoding video streams into the
  H.264/MPEG-4 AVC compression format. This version is optimized for
  OpenWrt embedded systems.
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-cli \
	--disable-asm \
	--enable-pic \
	--bit-depth=8 \
	--host=$(GNU_TARGET_NAME) \
	--cross-prefix=$(TARGET_CROSS)

TARGET_CFLAGS += $(FPIC)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/x264.h $(1)/usr/include/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/x264_config.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libx264.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/x264.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libx264/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libx264.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libx264))