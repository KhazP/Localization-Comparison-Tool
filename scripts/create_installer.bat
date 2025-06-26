@echo off
echo Creating Windows Installer...
echo.

REM Check if Inno Setup is installed
where iscc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Inno Setup not found in PATH.
    echo.
    echo To create a professional installer:
    echo 1. Download Inno Setup from: https://jrsoftware.org/isinfo.php
    echo 2. Install Inno Setup
    echo 3. Add the installation directory to your PATH environment variable
    echo 4. Run this script again
    echo.
    echo Alternative: Open scripts\windows_installer.iss in Inno Setup IDE
    echo.
    pause
    exit /b 1
)

echo Found Inno Setup. Creating installer...
iscc "scripts\windows_installer.iss"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo INSTALLER CREATED SUCCESSFULLY!
    echo ========================================
    echo.
    if exist "releases\windows\LocalizerApp-1.0.0-Setup.exe" (
        echo Installer: releases\windows\LocalizerApp-1.0.0-Setup.exe
        dir "releases\windows\LocalizerApp-1.0.0-Setup.exe"
    )
) else (
    echo.
    echo ERROR: Installer creation failed with error code %ERRORLEVEL%
    echo Please check the Inno Setup log for details.
)

echo.
pause