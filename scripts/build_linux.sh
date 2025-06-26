#!/bin/bash
echo "Building Localization Comparison Tool for Linux..."
echo

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean
flutter pub get

# Generate code
echo "Generating required code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Build Linux release
echo "Building Linux release..."
flutter build linux --release

# Check if build was successful
if [ ! -f "build/linux/x64/release/bundle/localizer_app_main" ]; then
    echo "ERROR: Build failed! Executable not found."
    exit 1
fi

# Create portable package
echo "Creating portable package..."
mkdir -p "releases/linux"

# Copy entire bundle and rename executable
cp -R "build/linux/x64/release/bundle" "releases/linux/LocalizerApp"
mv "releases/linux/LocalizerApp/localizer_app_main" "releases/linux/LocalizerApp/LocalizerApp"

# Create portable TAR.GZ
cd releases/linux
tar -czf "LocalizerApp-1.0.0-Linux.tar.gz" "LocalizerApp"
cd ../..

# Create AppImage (requires appimagetool)
if command -v appimagetool &> /dev/null; then
    echo "Creating AppImage..."
    
    # Create AppDir structure
    mkdir -p "releases/linux/LocalizerApp.AppDir/usr/bin"
    mkdir -p "releases/linux/LocalizerApp.AppDir/usr/share/applications"
    mkdir -p "releases/linux/LocalizerApp.AppDir/usr/share/icons/hicolor/256x256/apps"
    
    # Copy application
    cp -R "releases/linux/LocalizerApp/"* "releases/linux/LocalizerApp.AppDir/usr/bin/"
    
    # Create desktop file
    cat > "releases/linux/LocalizerApp.AppDir/LocalizerApp.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Localization Comparison Tool
Comment=Compare and analyze localization files
Exec=LocalizerApp
Icon=localizerapp
Categories=Development;Utility;
EOF
    
    # Copy icon (convert ICO to PNG if needed)
    if command -v convert &> /dev/null; then
        convert "assets/logo/localizerapp.ico" "releases/linux/LocalizerApp.AppDir/usr/share/icons/hicolor/256x256/apps/localizerapp.png"
        cp "releases/linux/LocalizerApp.AppDir/usr/share/icons/hicolor/256x256/apps/localizerapp.png" "releases/linux/LocalizerApp.AppDir/localizerapp.png"
    else
        echo "ImageMagick not found. Cannot convert icon for AppImage."
    fi
    
    # Make AppRun executable
    cp "releases/linux/LocalizerApp.AppDir/usr/bin/LocalizerApp" "releases/linux/LocalizerApp.AppDir/AppRun"
    chmod +x "releases/linux/LocalizerApp.AppDir/AppRun"
    
    # Create AppImage
    cd releases/linux
    appimagetool "LocalizerApp.AppDir" "LocalizerApp-1.0.0.AppImage"
    cd ../..
else
    echo "appimagetool not found. Install from https://appimage.github.io/appimagetool/"
    echo "Skipping AppImage creation."
fi

echo
echo "Linux build completed successfully!"
echo "Portable app: releases/linux/LocalizerApp-1.0.0-Linux.tar.gz"
echo "Executable: releases/linux/LocalizerApp/"
if [ -f "releases/linux/LocalizerApp-1.0.0.AppImage" ]; then
    echo "AppImage: releases/linux/LocalizerApp-1.0.0.AppImage"
fi
echo