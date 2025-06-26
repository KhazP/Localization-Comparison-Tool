# Building Localization Comparison Tool

This guide explains how to build the Localization Comparison Tool for distribution.

## Quick Build (Windows)

For most users, simply run:
```bash
scripts\build_windows_complete.bat
```

This will create:
- `releases\windows\LocalizerApp.exe` - Standalone executable
- `releases\windows\LocalizerApp-1.0.0-Portable.zip` - Portable package
- `releases\windows\LocalizerApp-1.0.0-Setup.exe` - Professional installer (if Inno Setup is installed)

## Prerequisites

### Required
- **Flutter SDK 3.19+** - Download from https://flutter.dev
- **Visual Studio with C++ tools** - For Windows desktop development

### Optional (for installer)
- **Inno Setup** - Download from https://jrsoftware.org/isinfo.php

## Build Process

### 1. Prepare Environment
```bash
flutter doctor    # Check Flutter installation
flutter clean     # Clean previous builds
flutter pub get   # Get dependencies
```

### 2. Build Application
```bash
# Generate required code files
flutter packages pub run build_runner build

# Build Windows release
flutter build windows --release
```

### 3. Create Distribution Package
The build script automatically:
- Copies the executable to `releases\windows\`
- Includes all required DLL files
- Creates a portable ZIP package
- Generates a professional installer (if tools are available)

## Advanced Building

### Cross-Platform Building
- **Windows**: Use `scripts\build_windows_complete.bat`
- **macOS**: Use `scripts/build_macos.sh` (requires macOS)
- **Linux**: Use `scripts/build_linux.sh` (requires Linux)

### Manual Building
If you prefer manual control:
```bash
# Clean and prepare
flutter clean
flutter pub get
flutter packages pub run build_runner build

# Build for specific platform
flutter build windows --release
flutter build macos --release    # macOS only
flutter build linux --release    # Linux only
```

## Distribution

### End User Downloads
Provide users with:
1. **Installer** (`LocalizerApp-1.0.0-Setup.exe`) - Recommended for most users
2. **Portable** (`LocalizerApp-1.0.0-Portable.zip`) - For users who prefer no installation

### System Requirements
- **Windows 10** version 1903 (build 18362) or later
- **x64 architecture** (ARM64 compatible)
- **200MB** available disk space

## Troubleshooting

### Common Issues

**Build fails with "Visual Studio not found":**
- Install Visual Studio Community with "Desktop development with C++" workload
- Restart command prompt after installation

**Flutter command not found:**
- Add Flutter bin directory to system PATH
- Restart command prompt

**Permission denied errors:**
- Run command prompt as Administrator
- Check antivirus software isn't blocking Flutter

**Missing dependencies:**
```bash
flutter doctor --verbose
```
This will show detailed information about missing requirements.

### Clean Build
If experiencing issues:
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner clean
flutter packages pub run build_runner build
```

## Development vs Release Builds

### Development
```bash
flutter run                    # Debug mode with hot reload
flutter run --release         # Release mode for testing
```

### Distribution
```bash
flutter build windows --release    # Optimized for distribution
```

Release builds are:
- Significantly smaller in size
- Optimized for performance
- Suitable for end-user distribution
- Do not include debugging symbols

## Signing and Security

### Code Signing (Optional)
For commercial distribution, consider code signing:
- Prevents "Unknown Publisher" warnings
- Increases user trust
- Required for some enterprise environments

### Antivirus Considerations
- Some antivirus software may flag unsigned executables
- Consider submitting builds to major antivirus vendors
- Provide checksums for integrity verification

## File Structure

After building, you'll find:
```
releases/windows/
├── LocalizerApp.exe                 # Main executable
├── flutter_windows.dll             # Flutter runtime
├── msvcp140.dll                     # Visual C++ runtime
├── vcruntime140.dll                 # Visual C++ runtime  
├── vcruntime140_1.dll               # Visual C++ runtime
├── data/                            # Application data
├── LocalizerApp-1.0.0-Portable.zip # Portable package
└── LocalizerApp-1.0.0-Setup.exe    # Installer
```

All files in the `releases/windows/` directory are required for the application to run properly.