# Build Scripts for Localization Comparison Tool

This directory contains build scripts to create distributable packages for Windows, macOS, and Linux.

## Quick Start

### Windows
```bash
# Build portable app and installer (recommended)
scripts\build_windows_complete.bat

# Or build portable app only
scripts\build_windows.bat
```

### macOS
```bash
# Build portable app and DMG installer
./scripts/build_macos.sh
```

### Linux
```bash
# Build portable app and AppImage
./scripts/build_linux.sh
```

### All Platforms
```bash
# Build for all available platforms
scripts\build_all.bat
```

## Requirements

### Windows
- **Flutter SDK** (3.19+)
- **Visual Studio** with C++ tools
- **Inno Setup** (optional, for installer creation)
  - Download from: https://jrsoftware.org/isinfo.php
  - Add to PATH for automatic installer creation

### macOS
- **Flutter SDK** (3.19+)
- **Xcode** with command line tools
- **create-dmg** (optional, for DMG creation)
  ```bash
  brew install create-dmg
  ```

### Linux
- **Flutter SDK** (3.19+)
- **Build essentials** and required libraries
- **appimagetool** (optional, for AppImage creation)
  - Download from: https://appimage.github.io/appimagetool/
- **ImageMagick** (optional, for icon conversion)
  ```bash
  sudo apt install imagemagick
  ```

## Output Structure

After building, the `releases/` directory will contain:

```
releases/
├── windows/
│   ├── LocalizerApp.exe                    # Portable executable
│   ├── *.dll                              # Required libraries
│   ├── data/                              # Flutter data files
│   ├── LocalizerApp-1.0.0-Portable.zip    # Portable package
│   └── LocalizerApp-1.0.0-Setup.exe       # Windows installer
├── macos/
│   ├── LocalizerApp.app/                  # macOS app bundle
│   ├── LocalizerApp-1.0.0-macOS.zip       # Portable package
│   └── LocalizerApp-1.0.0.dmg             # macOS installer
└── linux/
    ├── LocalizerApp/                      # Portable app directory
    ├── LocalizerApp-1.0.0-Linux.tar.gz    # Portable package
    └── LocalizerApp-1.0.0.AppImage        # Linux universal package
```

## Features

### Windows Package Features
- **Portable ZIP**: Self-contained package requiring no installation
- **Professional Installer**: 
  - Start menu shortcuts
  - Desktop icon (optional)
  - File associations for supported formats
  - Proper uninstallation
  - Registry integration

### macOS Package Features
- **App Bundle**: Standard macOS application format
- **DMG Installer**: Drag-to-Applications installer
- **Code signing ready** (requires Apple Developer account)

### Linux Package Features
- **Portable Directory**: Self-contained application
- **AppImage**: Universal Linux package that runs anywhere
- **Desktop integration**: Application menu entries and file associations

## Customization

### App Information
Edit the following files to customize app metadata:
- `windows/runner/Runner.rc` - Windows version info
- `scripts/windows_installer.iss` - Windows installer settings
- `scripts/build_macos.sh` - macOS app settings
- `scripts/build_linux.sh` - Linux app settings

### App Icon
The app icon is automatically used from `assets/logo/localizerapp.ico`.

### Version Numbers
Update version in `pubspec.yaml` and it will be automatically used in all builds.

## Troubleshooting

### Windows Build Issues
- Ensure Visual Studio with C++ tools is installed
- Run `flutter doctor` to check for missing dependencies
- If the build fails, try `flutter clean` first

### macOS Build Issues
- Ensure Xcode command line tools are installed: `xcode-select --install`
- For code signing issues, see Flutter's macOS deployment guide

### Linux Build Issues
- Install required development packages:
  ```bash
  sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev
  ```
- For AppImage issues, ensure appimagetool is executable

### Cross-Platform Building
- **Windows apps** can only be built on Windows
- **macOS apps** can only be built on macOS (due to Xcode requirement)
- **Linux apps** can be built on Linux or Windows Subsystem for Linux (WSL)

For true cross-platform building, consider using:
- GitHub Actions with multiple runners
- Docker containers for Linux builds
- Cloud CI/CD services

## Distribution

### Recommended Distribution Methods
- **Windows**: Provide both installer (.exe) and portable (.zip)
- **macOS**: Provide DMG for easy installation
- **Linux**: Provide AppImage for universal compatibility

### File Naming Convention
All packages follow the pattern: `LocalizerApp-{version}-{platform}.{extension}`

### Security
- Windows executables are unsigned (consider code signing for commercial distribution)
- macOS apps are unsigned (requires Apple Developer account for notarization)
- Linux packages include all dependencies for maximum compatibility