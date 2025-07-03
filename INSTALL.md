# Build and Install Guide

## Quick Start

1. **Fork this repository** to your GitHub account
2. **Enable GitHub Actions** in your repository settings
3. **Push to main branch** or manually trigger the workflow to start building
4. **Download artifacts** from the completed workflow run

## Using the Built Packages

### On OpenWrt Device

```bash
# Transfer IPK files to your OpenWrt device
scp *.ipk root@192.168.1.1:/tmp/

# SSH to your OpenWrt device
ssh root@192.168.1.1

# Install the packages
cd /tmp
opkg install libx264_*.ipk
opkg install ffmpeg_*.ipk

# Verify installation
ffmpeg -version
ffprobe -version
```

### Example Usage

```bash
# Convert video with H.264 encoding
ffmpeg -i input.avi -c:v libx264 -preset medium -crf 23 output.mp4

# Analyze media file
ffprobe -v quiet -print_format json -show_format -show_streams input.mp4

# Stream camera to network
ffmpeg -f v4l2 -i /dev/video0 -c:v libx264 -preset ultrafast -f rtp rtp://224.1.1.1:5004
```

## Build Configuration

The build includes these key features:

- **H.264 Encoding**: Via libx264 library
- **H.264 Decoding**: Native FFmpeg decoder
- **Format Support**: MP4, AVI, TS, and common formats
- **Protocol Support**: HTTP, RTP, UDP, TCP
- **Optimized Size**: Minimal footprint for embedded systems

## Troubleshooting

### Build Failures

1. **SDK Download Issues**: Check OpenWrt download servers status
2. **Dependency Errors**: Ensure all required packages are available
3. **Compilation Errors**: Review build logs in GitHub Actions

### Installation Issues

1. **Package Conflicts**: Remove existing FFmpeg packages first
2. **Dependency Missing**: Install libx264 before FFmpeg
3. **Storage Space**: Ensure sufficient space on OpenWrt device

### Runtime Issues

1. **Missing Codecs**: Check FFmpeg build configuration
2. **Performance**: Adjust encoder presets for your hardware
3. **Memory Issues**: Monitor system resources during encoding

## Support

- Check GitHub Issues for common problems
- Review OpenWrt documentation for package management
- Consult FFmpeg documentation for usage examples
