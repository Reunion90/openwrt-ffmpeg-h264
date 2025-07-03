# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-07-04

### Added
- Initial release of OpenWrt FFmpeg H.264 build system
- Support for OpenWrt 24.10 x86_64 target
- FFmpeg 6.1.1 with H.264 encoding/decoding
- libx264 integration for H.264 support
- GitHub Actions automated build workflow
- Complete build and installation documentation

### Features
- **FFmpeg Full Package**: Complete FFmpeg binary with comprehensive codec support
- **FFprobe Tool**: Media analysis and information extraction
- **H.264 Support**: Hardware-optimized encoding and decoding
- **Cross-compilation**: Built for OpenWrt embedded systems
- **Automated Builds**: GitHub Actions CI/CD pipeline
- **Release Management**: Automatic artifact generation and releases

### Technical Specifications
- **OpenWrt Version**: 24.10
- **Target Architecture**: x86_64
- **FFmpeg Version**: 6.1.1
- **libx264 Version**: Latest stable from VideoLAN repository
- **Build System**: OpenWrt SDK with custom Makefiles
- **License**: GPL v2+ compliant

### Build Components
- Custom OpenWrt Makefiles for FFmpeg and libx264
- GitHub Actions workflow for automated compilation
- Comprehensive build artifact collection
- Release automation for tagged versions

### Package Contents
- `libx264`: H.264 encoding library (~2MB)
- `ffmpeg-full`: Complete FFmpeg binary (~8MB)
- `ffprobe-full`: Media analysis tool (included with FFmpeg)

### Installation Requirements
- OpenWrt 24.10 compatible device
- x86_64 architecture support
- Minimum 10MB free storage space
- Network connectivity for package installation
