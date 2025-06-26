#!/bin/bash
echo "Building Localization Comparison Tool for macOS..."
echo

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean
flutter pub get

# Generate code
echo "Generating required code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Build macOS release
echo "Building macOS release..."
flutter build macos --release

# Check if build was successful
if [ ! -d "build/macos/Build/Products/Release/localizer_app_main.app" ]; then
    echo "ERROR: Build failed! App bundle not found."
    exit 1
fi

# Create portable package
echo "Creating portable package..."
mkdir -p "releases/macos"

# Copy app bundle and rename
cp -R "build/macos/Build/Products/Release/localizer_app_main.app" "releases/macos/LocalizerApp.app"

# Create portable ZIP
cd releases/macos
zip -r "LocalizerApp-1.0.0-macOS.zip" "LocalizerApp.app"
cd ../..

# Create DMG installer (requires create-dmg tool)
if command -v create-dmg &> /dev/null; then
    echo "Creating DMG installer..."
    create-dmg \
        --volname "Localization Comparison Tool" \
        --volicon "assets/logo/localizerapp.ico" \
        --window-pos 200 120 \
        --window-size 600 300 \
        --icon-size 100 \
        --icon "LocalizerApp.app" 175 120 \
        --hide-extension "LocalizerApp.app" \
        --app-drop-link 425 120 \
        "releases/macos/LocalizerApp-1.0.0.dmg" \
        "releases/macos/"
else
    echo "create-dmg not found. Install with: brew install create-dmg"
    echo "Skipping DMG creation."
fi

echo
echo "macOS build completed successfully!"
echo "Portable app: releases/macos/LocalizerApp-1.0.0-macOS.zip"
echo "App bundle: releases/macos/LocalizerApp.app"
if [ -f "releases/macos/LocalizerApp-1.0.0.dmg" ]; then
    echo "DMG installer: releases/macos/LocalizerApp-1.0.0.dmg"
fi
echo