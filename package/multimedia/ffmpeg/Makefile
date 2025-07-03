#
# Copyright (C) 2017-2018 Ian Leonard <antonlacon@gmail.com>
# Copyright (C) 2018 Ted Hess <thess@kitschensync.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ffmpeg
PKG_VERSION:=6.1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://ffmpeg.org/releases/
PKG_HASH:=8684f4b00f94b85461884c3719382f1261f0d9eb3d59640a93e9c72e3e8e2f26

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>, \
		Ian Leonard <antonlacon@gmail.com>
PKG_LICENSE:=LGPL-2.1-or-later GPL-2.0-or-later LGPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv2.1 COPYING.LGPLv3
PKG_CPE_ID:=cpe:/a:ffmpeg:ffmpeg

FFMPEG_CUSTOM_ENCODERS:= \
	ac3 \
	jpegls \
	mpeg1video \
	mpeg2video \
	mpeg4 \
	pcm_s16be \
	pcm_s16le \
	png \
	vorbis \
	zlib \
	libx264 \

FFMPEG_CUSTOM_DECODERS:= \
	aac \
	ac3 \
	alac \
	amrnb \
	amrwb \
	ape \
	atrac3 \
	flac \
	gif \
	h264 \
	hevc \
	jpegls \
	mp2 \
	mp3 \
	mpeg1video \
	mpeg2video \
	mpeg4 \
	mpegvideo \
	mpc7 \
	mpc8 \
	pcm_s16be \
	pcm_s16le \
	png \
	rawvideo \
	vorbis \
	wavpack \
	wmav1 \
	wmav2 \
	zlib \

FFMPEG_CUSTOM_MUXERS:= \
	ac3 \
	ffm \
	h264 \
	hevc \
	mp3 \
	mp4 \
	mpeg1video \
	mpeg2video \
	mpegts \
	ogg \
	rtp \

FFMPEG_CUSTOM_DEMUXERS:= \
	aac \
	ac3 \
	amr \
	ape \
	avi \
	flac \
	ffm \
	h264 \
	hevc \
	matroska \
	mov \
	mp3 \
	mpegps \
	mpegts \
	mpegvideo \
	mpc \
	mpc8 \
	ogg \
	rm \
	rtsp \
	rtp \
	sdp \
	v4l2 \
	vc1 \
	wav \
	wv \

FFMPEG_CUSTOM_PARSERS:= \
	aac \
	flac \
	ac3 \
	h264 \
	hevc \
	mpegaudio \
	mpeg4video \
	mpegvideo \
	vc1 \

FFMPEG_CUSTOM_PROTOCOLS:= \
	file http icecast pipe rtp tcp udp

FFMPEG_MINI_DECODERS:= \
	ac3 \
	flac \
	jpegls \
	mp2 \
	mp3 \
	mpeg1video \
	mpeg2video \
	mpeg4 \
	mpegvideo \
	png \
	rawvideo \

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_CONFIG_DEPENDS:= \
	$(patsubst %,CONFIG_FFMPEG_CUSTOM_ENCODER_%,$(FFMPEG_CUSTOM_ENCODERS)) \
	$(patsubst %,CONFIG_FFMPEG_CUSTOM_DECODER_%,$(FFMPEG_CUSTOM_DECODERS)) \
	$(patsubst %,CONFIG_FFMPEG_CUSTOM_MUXER_%,$(FFMPEG_CUSTOM_MUXERS)) \
	$(patsubst %,CONFIG_FFMPEG_CUSTOM_DEMUXER_%,$(FFMPEG_CUSTOM_DEMUXERS)) \
	$(patsubst %,CONFIG_FFMPEG_CUSTOM_PARSER_%,$(FFMPEG_CUSTOM_PARSERS)) \
	$(patsubst %,CONFIG_FFMPEG_CUSTOM_PROTOCOL_%,$(FFMPEG_CUSTOM_PROTOCOLS))

include $(INCLUDE_DIR)/package.mk

define Package/ffmpeg/Default
 TITLE:=FFmpeg
 URL:=https://ffmpeg.org/
 DEPENDS+= +libpthread +zlib
endef

define Package/ffmpeg/Default/description
 FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video.
endef

# Package definitions
define Package/ffmpeg-full
$(call Package/ffmpeg/Default)
 SECTION:=multimedia
 CATEGORY:=Multimedia
 TITLE+= program (full)
 DEPENDS+= +libx264 +alsa-lib +PACKAGE_libopus:libopus +libx264
 VARIANT:=full
 PROVIDES:=ffmpeg
endef

define Package/ffmpeg-full/description
$(call Package/ffmpeg/Default/description)
 .
 This package contains the FFmpeg command line tool which includes ffmpeg and ffprobe.
 It's compiled with support for most formats and codecs including H.264 via libx264.
endef

# Package: ffprobe
define Package/ffprobe-full
$(call Package/ffmpeg/Default)
 SECTION:=multimedia
 CATEGORY:=Multimedia
 TITLE+= CLI media identifier (full)
 DEPENDS+= +libx264 +alsa-lib +PACKAGE_libopus:libopus
 VARIANT:=full
 PROVIDES:=ffprobe
endef

define Package/ffprobe-full/description
$(call Package/ffmpeg/Default/description)
 .
 This package contains the ffprobe command line tool for multimedia stream analysis.
endef

FFMPEG_CONFIGURE:= \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	./configure \
	--enable-cross-compile \
	--cross-prefix="$(TARGET_CROSS)" \
	--arch="$(ARCH)" \
	--target-os=linux \
	--prefix="/usr" \
	--pkg-config="pkg-config" \
	--enable-shared \
	--enable-static \
	--enable-pthreads \
	--enable-zlib \
	--disable-doc \
	--disable-debug \
	\
	--enable-gpl \
	--enable-version3 \
	\
	--disable-lzma \
	--disable-vaapi \
	--disable-vdpau \
	--disable-outdevs

ifeq ($(BUILD_VARIANT),full)

FFMPEG_CONFIGURE+= \
	--enable-libx264 \
	--enable-encoder=libx264 \
	--enable-decoder=h264 \
	--enable-muxer=h264 \
	--enable-demuxer=h264 \
	--enable-parser=h264 \
	$(call FFMPEG_ENABLE,encoder,$(FFMPEG_CUSTOM_ENCODERS)) \
	$(call FFMPEG_ENABLE,decoder,$(FFMPEG_CUSTOM_DECODERS)) \
	$(call FFMPEG_ENABLE,muxer,$(FFMPEG_CUSTOM_MUXERS)) \
	$(call FFMPEG_ENABLE,demuxer,$(FFMPEG_CUSTOM_DEMUXERS)) \
	$(call FFMPEG_ENABLE,parser,$(FFMPEG_CUSTOM_PARSERS)) \
	$(call FFMPEG_ENABLE,protocol,$(FFMPEG_CUSTOM_PROTOCOLS))

endif

FFMPEG_ENABLE=--enable-$(1)=$(subst $(space),$(comma),$(2))

define Build/Configure
	( cd $(PKG_BUILD_DIR); $(FFMPEG_CONFIGURE) )
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/ffmpeg-full/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ffmpeg $(1)/usr/bin/
endef

define Package/ffprobe-full/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ffprobe $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ffmpeg-full))
$(eval $(call BuildPackage,ffprobe-full))
