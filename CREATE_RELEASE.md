# 🚀 How to Create GitHub Release

## Step 1: Push to GitHub

First, create a GitHub repository and push your code:

```bash
# Add GitHub remote (replace with your repository URL)
git remote add origin https://github.com/YOUR_USERNAME/openwrt-ffmpeg-h264.git

# Push code and tags
git push -u origin main
git push origin v1.0.0
```

## Step 2: Trigger Build

The GitHub Actions workflow will automatically start building when you push. You can also:

1. Go to **Actions** tab in your GitHub repository
2. Click on **"Build FFmpeg for OpenWrt 24.10 x86_64"** workflow
3. Click **"Run workflow"** button to trigger manually

## Step 3: Create Release

Once the build completes successfully:

1. **Go to Releases**
   - Navigate to your GitHub repository
   - Click on **"Releases"** (right sidebar)
   - Click **"Create a new release"**

2. **Configure Release**
   - **Tag version**: `v1.0.0`
   - **Release title**: `v1.0.0 - OpenWrt FFmpeg H.264 Build`
   - **Description**: Copy content from `RELEASE_NOTES.md`

3. **Attach Build Artifacts**
   - Download artifacts from the completed GitHub Actions workflow
   - Upload the `.ipk` files to the release
   - The workflow automatically creates release if you push a tag

## Expected Build Artifacts

After successful build, you should have:

```
📦 openwrt-ffmpeg-h264-24.10.0-x86-64/
├── 📄 BUILD_INFO.md
├── 📦 libx264_*.ipk
├── 📦 ffmpeg-full_*.ipk
└── 📦 ffprobe-full_*.ipk
```

## Automated Release

The GitHub Actions workflow is configured to automatically create releases when you push tags:

```bash
# Create and push new tag for automatic release
git tag v1.0.1
git push origin v1.0.1
```

This will:
- ✅ Build packages automatically
- ✅ Create GitHub release
- ✅ Upload .ipk files as release assets
- ✅ Generate build information

## Release Features

Your release will include:

- 🎯 **Ready-to-install packages** for OpenWrt 24.10.0 x86_64
- 📋 **Build information** with package details
- 🔍 **SHA256 checksums** for package verification
- 📖 **Complete documentation** and usage examples
- 🤖 **Automated builds** for future updates

## Next Steps

1. **Test the packages** on an OpenWrt device
2. **Share with community** on OpenWrt forums
3. **Accept contributions** from other developers
4. **Regular updates** when new FFmpeg versions are released

Ready to create your first release! 🚀
