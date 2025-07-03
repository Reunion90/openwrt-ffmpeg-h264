PKG_NAME:=libx264
PKG_VERSION:=20240513
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://code.videolan.org/videolan/x264.git
PKG_SOURCE_VERSION:=31e19f92f00c7003fa115047ce50978bc98c3a0d
PKG_MIRROR_HASH:=7c78e1a6d8b7e4c1d41b38f9c7d14bb6de1eeb0ba9f3c2bb8e8fb8e8f8a1e2b4

PKG_MAINTAINER:=Adrian Panella <ianchi74@outlook.com>
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
  TITLE:=H.264/AVC free software library
  URL:=https://www.videolan.org/developers/x264.html
  ABI_VERSION:=164
endef

define Package/libx264/description
  x264 is a free software library and application for encoding video streams
  into the H.264/MPEG-4 AVC compression format, and is released under the
  terms of the GNU GPL. This version is compiled without assembly optimizations
  for maximum compatibility with cross-compilation.
endef

# Completely disable assembly and use only C code
CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-cli \
	--disable-asm \
	--disable-opencl \
	--enable-pic \
	--bit-depth=8 \
	--chroma-format=420 \
	--disable-interlaced \
	--disable-avs \
	--disable-swscale \
	--disable-lavf \
	--disable-ffms \
	--disable-gpac \
	--disable-lsmash \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--cross-prefix=$(TARGET_CROSS)

# Force disable all assembly-related tools and features
CONFIGURE_VARS += \
	AS=":" \
	ac_cv_prog_AS="" \
	ac_cv_prog_NASM="" \
	ac_cv_prog_YASM="" \
	asm=no \
	HAVE_X86ASM=no \
	have_x86inc=no

TARGET_CFLAGS += $(FPIC) -fno-strict-aliasing -DHAVE_MALLOC_H
TARGET_LDFLAGS += -Wl,--gc-sections

define Build/Configure
	( cd $(PKG_BUILD_DIR); \
		$(CONFIGURE_VARS) \
		./configure \
			$(CONFIGURE_ARGS) \
	)
	# Ensure no assembly is compiled
	find $(PKG_BUILD_DIR) -name "*.asm" -delete || true
	find $(PKG_BUILD_DIR) -name "*-asm.c" -delete || true
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/x264
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
