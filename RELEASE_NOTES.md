# Release v1.0.0 - OpenWrt FFmpeg H.264 Build

## 🎯 Initial Release

This is the first release of the OpenWrt FFmpeg H.264 build project for **OpenWrt 24.10.0 x86_64**.

## ✨ Features

### Core Components
- **FFmpeg 6.1.1** - Complete multimedia framework
- **FFprobe** - Media analysis tool  
- **libx264** - High-quality H.264 encoding library

### Build System
- **GitHub Actions** automated build workflow
- **OpenWrt SDK 24.10.0** for x86_64 target
- **Cross-compilation** optimized for embedded systems
- **Automated releases** with .ipk package generation

### Video Capabilities
- **H.264 Encoding** via libx264 library
- **H.264 Decoding** with native FFmpeg decoder
- **Multiple formats** support (MP4, AVI, TS, etc.)
- **Network protocols** (HTTP, RTP, UDP, TCP)

## 📦 Package Contents

| Package | Description | Size |
|---------|-------------|------|
| `libx264_*.ipk` | H.264 encoding library | ~2MB |
| `ffmpeg-full_*.ipk` | Complete FFmpeg binary | ~8MB |
| `ffprobe-full_*.ipk` | Media analysis tool | Included with FFmpeg |

## 🚀 Quick Start

### 1. Download Packages
Download the `.ipk` files from the release assets below.

### 2. Install on OpenWrt Device
```bash
# Copy to your OpenWrt device
scp *.ipk root@your-openwrt-device:/tmp/

# Install packages
ssh root@your-openwrt-device
cd /tmp
opkg install libx264_*.ipk
opkg install ffmpeg_*.ipk
```

### 3. Verify Installation
```bash
ffmpeg -version
ffprobe -version
```

## 🎬 Usage Examples

### H.264 Video Encoding
```bash
ffmpeg -i input.avi -c:v libx264 -preset medium -crf 23 output.mp4
```

### Media Analysis
```bash
ffprobe -v quiet -print_format json -show_streams input.mp4
```

### Live Streaming
```bash
ffmpeg -f v4l2 -i /dev/video0 -c:v libx264 -preset ultrafast -f rtp rtp://224.1.1.1:5004
```

## 🔧 System Requirements

- **OpenWrt 24.10.0** compatible device
- **x86_64 architecture** support
- **10MB free storage** space
- **Network connectivity** for installation

## 🏗️ Building from Source

### Automatic Build
1. Fork this repository
2. Enable GitHub Actions
3. Push to main branch or trigger workflow manually
4. Download artifacts from completed workflow

### Manual Build
```bash
# Download OpenWrt SDK
wget https://downloads.openwrt.org/releases/24.10.0/targets/x86/64/openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.zst

# Extract and build
tar -xf openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.zst
cd openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64
cp -r /path/to/repo/package/* package/
make package/ffmpeg/compile V=s
```

## 📄 License

This project is licensed under MIT License. However, the compiled packages contain:

- **FFmpeg**: LGPL v2.1+ / GPL v2+ / LGPL v3.0+
- **libx264**: GPL v2+

Please ensure compliance with these licenses when distributing the compiled packages.

## 🤝 Contributing

- Report issues on GitHub
- Submit pull requests for improvements
- Check OpenWrt documentation for package development

## 🔗 Links

- [OpenWrt Project](https://openwrt.org/)
- [FFmpeg Documentation](https://ffmpeg.org/documentation.html)
- [libx264 Project](https://www.videolan.org/developers/x264.html)

---

**Built with ❤️ for the OpenWrt community**
