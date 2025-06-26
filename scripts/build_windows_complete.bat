@echo off
echo Building Complete Windows Package for Localization Comparison Tool...
echo.

REM Check if Inno Setup is installed
where iscc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: Inno Setup not found in PATH.
    echo Please install Inno Setup from https://jrsoftware.org/isinfo.php
    echo to create the installer. Continuing with portable build only...
    echo.
    set SKIP_INSTALLER=1
) else (
    set SKIP_INSTALLER=0
)

REM Clean previous builds
echo Cleaning previous builds...
flutter clean
flutter pub get

REM Generate code
echo Generating required code...
flutter packages pub run build_runner build --delete-conflicting-outputs

REM Build Windows release
echo Building Windows release...
flutter build windows --release

REM Check if build was successful
if not exist "build\windows\x64\runner\Release\localizer_app_main.exe" (
    echo ERROR: Build failed! Executable not found.
    pause
    exit /b 1
)

REM Create releases directory
echo Creating releases directory...
if not exist "releases\windows" mkdir "releases\windows"

REM Remove old files
if exist "releases\windows\LocalizerApp.exe" del "releases\windows\LocalizerApp.exe"
if exist "releases\windows\*.dll" del "releases\windows\*.dll"
if exist "releases\windows\data" rmdir /s /q "releases\windows\data"
if exist "releases\windows\LocalizerApp-1.0.0-Portable.zip" del "releases\windows\LocalizerApp-1.0.0-Portable.zip"

REM Copy executable and rename
echo Creating portable package...
copy "build\windows\x64\runner\Release\localizer_app_main.exe" "releases\windows\LocalizerApp.exe"

REM Copy required DLLs
copy "build\windows\x64\runner\Release\*.dll" "releases\windows\"

REM Copy data directory if it exists
if exist "build\windows\x64\runner\Release\data" (
    xcopy "build\windows\x64\runner\Release\data" "releases\windows\data\" /E /I /Y
)

REM Create portable ZIP
echo Creating portable ZIP package...
cd releases\windows
powershell -command "Compress-Archive -Path '.\LocalizerApp.exe','.\*.dll','.\data' -DestinationPath '.\LocalizerApp-1.0.0-Portable.zip' -Force"
cd ..\..

REM Create installer if Inno Setup is available
if %SKIP_INSTALLER% EQU 0 (
    echo Creating Windows installer...
    iscc "scripts\windows_installer.iss"
    if %ERRORLEVEL% EQU 0 (
        echo Installer created successfully!
    ) else (
        echo WARNING: Installer creation failed.
    )
) else (
    echo Skipping installer creation (Inno Setup not found).
)

echo.
echo ========================================
echo Windows build completed successfully!
echo ========================================
echo.
echo Files created:
echo - Portable ZIP: releases\windows\LocalizerApp-1.0.0-Portable.zip
echo - Executable:  releases\windows\LocalizerApp.exe
if %SKIP_INSTALLER% EQU 0 (
    if exist "releases\windows\LocalizerApp-1.0.0-Setup.exe" (
        echo - Installer:    releases\windows\LocalizerApp-1.0.0-Setup.exe
    )
)
echo.
echo To create the installer, install Inno Setup from:
echo https://jrsoftware.org/isinfo.php
echo Then run: iscc scripts\windows_installer.iss
echo.
pause