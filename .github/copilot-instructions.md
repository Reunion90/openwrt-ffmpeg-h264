<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# OpenWrt FFmpeg H.264 Build Project

This is an OpenWrt package build project for compiling FFmpeg and FFprobe with H.264 support using libx264.

## Build Context

- **Target Platform**: OpenWrt 24.10 x86_64
- **Build System**: OpenWrt SDK with custom Makefiles
- **Output**: IPK packages for installation on OpenWrt devices

## Key Components

1. **FFmpeg Package** (`package/multimedia/ffmpeg/Makefile`):
   - Builds FFmpeg and FFprobe binaries
   - Includes H.264 encoding/decoding support via libx264
   - Configured for embedded systems optimization

2. **libx264 Package** (`package/libs/libx264/Makefile`):
   - H.264 encoding library dependency
   - Optimized for OpenWrt target architecture

3. **GitHub Actions Workflow** (`.github/workflows/build.yml`):
   - Automated build using OpenWrt SDK
   - Artifact generation and release management

## Development Guidelines

When working with this project:

- Follow OpenWrt Makefile conventions and variable naming
- Use appropriate PKG_* variables for package metadata
- Ensure cross-compilation compatibility
- Test builds locally before committing
- Update version numbers and hashes when updating source packages
- Maintain compatibility with OpenWrt 24.10 target specifications

## Build Dependencies

The project requires:
- OpenWrt SDK 24.10 for x86_64
- Standard OpenWrt build tools
- Git access to source repositories
- Sufficient disk space for compilation artifacts
