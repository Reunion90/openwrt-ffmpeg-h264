# OpenWrt FFmpeg H.264 Build

This project builds FFmpeg and FFprobe for OpenWrt 24.10 x86_64 with libx264 and H.264 support using GitHub Actions.

## Features

- **Target Platform**: OpenWrt 24.10 x86_64
- **FFmpeg Components**: ffmpeg, ffprobe
- **Video Codecs**: H.264 encoding/decoding with libx264
- **Build System**: GitHub Actions with OpenWrt SDK
- **Output**: Ready-to-install .ipk packages

## Build Process

The GitHub Actions workflow automatically:

1. Downloads OpenWrt 24.10.0 SDK for x86_64
2. Configures the build environment
3. Compiles libx264 as a dependency
4. Builds FFmpeg with H.264 support
5. Creates installable .ipk packages
6. Uploads build artifacts

## Usage

### Automatic Build

Push to the repository or manually trigger the workflow in GitHub Actions to start the build process.

### Manual Build

If you want to build locally with OpenWrt SDK:

```bash
# Download OpenWrt SDK 24.10.0 for x86_64
wget https://downloads.openwrt.org/releases/24.10.0/targets/x86/64/openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.zst

# Extract SDK
tar -xf openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.zst
cd openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64

# Copy package files
cp -r /path/to/this/repo/package/* package/

# Build
make package/ffmpeg/compile V=s
```

## Installation on OpenWrt

After the build completes, download the .ipk files from GitHub Actions artifacts and install on your OpenWrt device:

```bash
# Copy .ipk files to your OpenWrt device
scp *.ipk root@openwrt-device:/tmp/

# Install on OpenWrt device
ssh root@openwrt-device
cd /tmp
opkg install libx264_*.ipk
opkg install ffmpeg_*.ipk
```

## Package Contents

- **libx264**: H.264 encoding library
- **ffmpeg**: Complete FFmpeg binary with H.264 support
- **ffprobe**: Media analysis tool

## Configuration

The build includes the following FFmpeg features:

- H.264 encoding/decoding (libx264)
- Essential formats and protocols
- Optimized for embedded systems
- Minimal size footprint

## Requirements

- OpenWrt 24.10 compatible device (x86_64)
- Sufficient storage space (~10MB for full installation)
- Internet connection for package installation

## License

FFmpeg and libx264 are distributed under their respective licenses:

- FFmpeg: LGPL v2.1+ / GPL v2+
- libx264: GPL v2+

Please ensure compliance with these licenses when distributing the compiled packages.
