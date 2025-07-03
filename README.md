# OpenWrt FFmpeg H.264 Build

Simple build system for FFmpeg with H.264 support on OpenWrt 24.10.0 x86_64.

## Quick Start

### Automatic Build (GitHub Actions)

1. **Fork this repository** and enable Actions
2. **Trigger workflow** manually or push changes
3. **Download packages** from workflow artifacts

### Manual Build

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/openwrt-ffmpeg-h264.git
cd openwrt-ffmpeg-h264

# Make script executable
chmod +x build-ffmpeg.sh

# Run build (requires Ubuntu/Debian with build tools)
./build-ffmpeg.sh
```

## Requirements

- **Ubuntu/Debian** build environment
- **Build tools**: gcc, make, wget, tar
- **Internet connection** for downloading OpenWrt SDK
- **~2GB disk space** for SDK and build

## What It Builds

- **FFmpeg** - Complete multimedia framework
- **libx264** - H.264 encoding library (if needed)
- **Dependencies** - Required libraries

## Installation on OpenWrt

```bash
# Copy packages to OpenWrt device
scp output/*.ipk root@192.168.1.1:/tmp/

# Install packages
ssh root@192.168.1.1
cd /tmp
opkg install *.ipk

# Test installation
ffmpeg -version
ffprobe -version
```

## Usage Examples

```bash
# H.264 video encoding
ffmpeg -i input.avi -c:v libx264 -preset medium output.mp4

# Stream analysis
ffprobe -v quiet -print_format json -show_streams video.mp4

# Live streaming
ffmpeg -f v4l2 -i /dev/video0 -c:v libx264 -f rtp rtp://224.1.1.1:5004
```

## Features

- ✅ **OpenWrt 24.10.0** x86_64 target
- ✅ **H.264 encoding/decoding** support
- ✅ **Automatic builds** via GitHub Actions
- ✅ **Simple build script** for local builds
- ✅ **Ready-to-install** .ipk packages

## Build Process

1. **Downloads** OpenWrt SDK 24.10.0 for x86_64
2. **Updates** package feeds
3. **Configures** build for multimedia packages
4. **Builds** FFmpeg and dependencies
5. **Collects** .ipk packages in `output/` directory

## Troubleshooting

### Build Fails
- Check internet connection for SDK download
- Ensure all build dependencies are installed
- Check available disk space (need ~2GB)

### No Packages Generated
- Review build logs for specific errors
- Some packages may not be available in OpenWrt 24.10.0 feeds
- Try building individual components

### Installation Issues
- Verify OpenWrt device architecture (x86_64)
- Check available storage on OpenWrt device
- Install dependencies first if needed

## License

Code: MIT License  
FFmpeg: LGPL/GPL (see FFmpeg documentation)  
libx264: GPL v2+ (see x264 documentation)
