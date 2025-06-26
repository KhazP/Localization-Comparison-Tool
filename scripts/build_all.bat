@echo off
echo Building Localization Comparison Tool for all platforms...
echo.

REM Build Windows
echo ========================================
echo Building Windows version...
echo ========================================
call scripts\build_windows.bat

echo.
echo ========================================
echo All builds completed!
echo ========================================
echo.
echo Check the releases/ directory for built applications:
echo - Windows: releases\windows\
echo.

REM Note: macOS and Linux builds require their respective platforms
echo Note: macOS and Linux builds require running on their respective platforms.
echo For cross-platform builds, use GitHub Actions or platform-specific machines.
echo.
pause