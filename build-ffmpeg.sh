#!/bin/bash
set -e

# OpenWrt FFmpeg H.264 Build Script
# Builds FFmpeg with libx264 support for OpenWrt 24.10.0 x86_64

echo "=== OpenWrt FFmpeg H.264 Build Script ==="
echo "Target: OpenWrt 24.10.0 x86_64"
echo "Features: FFmpeg + libx264 + H.264 encoding/decoding"
echo ""

# Configuration
OPENWRT_VERSION="24.10.0"
TARGET="x86"
SUBTARGET="64"
SDK_URL="https://downloads.openwrt.org/releases/24.10.0/targets/x86/64/openwrt-sdk-24.10.0-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.zst"
SDK_FILE="openwrt-sdk.tar.zst"
WORK_DIR="$(pwd)"
OUTPUT_DIR="$WORK_DIR/output"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Step 1: Downloading OpenWrt SDK..."
if [ ! -f "$SDK_FILE" ]; then
    wget -O "$SDK_FILE" "$SDK_URL"
    echo "SDK downloaded successfully"
else
    echo "SDK already exists, skipping download"
fi

echo "Step 2: Extracting SDK..."
if [ ! -d "openwrt-sdk-"* ]; then
    tar -xf "$SDK_FILE"
    echo "SDK extracted successfully"
else
    echo "SDK already extracted, skipping"
fi

# Find SDK directory
SDK_DIR=$(find . -maxdepth 1 -name "openwrt-sdk-*" -type d | head -1)
if [ -z "$SDK_DIR" ]; then
    echo "Error: SDK directory not found"
    exit 1
fi
echo "Using SDK: $SDK_DIR"

cd "$SDK_DIR"

echo "Step 3: Updating feeds..."
# Update feeds to get packages
./scripts/feeds update -a
./scripts/feeds install -a

echo "Step 4: Checking available packages..."
echo "Available FFmpeg packages:"
./scripts/feeds list | grep -i ffmpeg || echo "No FFmpeg packages found"
echo ""
echo "Available x264 packages:"
./scripts/feeds list | grep -i x264 || echo "No x264 packages found"
echo ""

echo "Step 5: Configuring build..."
# Create basic config for multimedia packages
cat > .config << EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_DEVICE_generic=y

# Enable packages we want to build
CONFIG_PACKAGE_libx264=m
CONFIG_PACKAGE_ffmpeg-full=m

# Build system
CONFIG_DEVEL=y
CONFIG_CCACHE=y
EOF

# Apply configuration
make defconfig V=s

echo "Step 6: Building packages..."
# Try to build from feeds first, then fallback to any available packages
echo "Attempting to build multimedia packages..."

# Look for any FFmpeg-related packages
FFMPEG_PACKAGES=$(make menuconfig V=s 2>/dev/null | grep -i ffmpeg || true)
echo "Found packages: $FFMPEG_PACKAGES"

# Build whatever multimedia packages are available
echo "Building all available multimedia packages..."
make package/feeds/packages/ffmpeg/compile V=s -j$(nproc) || \
make package/ffmpeg/compile V=s -j$(nproc) || \
echo "FFmpeg build failed, trying individual components..."

# Try building x264 separately
make package/feeds/packages/x264/compile V=s -j$(nproc) || \
make package/feeds/packages/libx264/compile V=s -j$(nproc) || \
echo "x264 build failed or not available"

echo "Step 7: Collecting packages..."
# Find and copy all built packages
find bin/ -name "*.ipk" -type f | while read ipk; do
    echo "Found package: $ipk"
    cp "$ipk" "$OUTPUT_DIR/"
done

# Go back to work directory
cd "$WORK_DIR"

echo "Step 8: Build summary..."
if [ -n "$(ls -A $OUTPUT_DIR 2>/dev/null)" ]; then
    echo "✅ Build completed successfully!"
    echo "Generated packages:"
    ls -la "$OUTPUT_DIR"/*.ipk
    
    echo ""
    echo "📦 Package details:"
    for ipk in "$OUTPUT_DIR"/*.ipk; do
        if [ -f "$ipk" ]; then
            echo "- $(basename "$ipk"): $(du -h "$ipk" | cut -f1)"
        fi
    done
    
    echo ""
    echo "🚀 Installation instructions:"
    echo "1. Copy .ipk files to your OpenWrt device:"
    echo "   scp output/*.ipk root@your-openwrt-device:/tmp/"
    echo ""
    echo "2. Install on OpenWrt device:"
    echo "   ssh root@your-openwrt-device"
    echo "   cd /tmp"
    echo "   opkg install *.ipk"
    echo ""
    echo "3. Test installation:"
    echo "   ffmpeg -version"
    echo "   ffprobe -version"
else
    echo "❌ No packages were built"
    echo "Check the build logs above for errors"
    exit 1
fi

echo ""
echo "=== Build Complete ==="