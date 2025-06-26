@echo off
echo Building Localization Comparison Tool for Windows...
echo.

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

REM Create portable package
echo Creating portable package...
if not exist "releases\windows" mkdir "releases\windows"

REM Copy executable and rename
copy "build\windows\x64\runner\Release\localizer_app_main.exe" "releases\windows\LocalizerApp.exe"

REM Copy required DLLs and data files
xcopy "build\windows\x64\runner\Release\*.dll" "releases\windows\" /Y
if exist "build\windows\x64\runner\Release\data" (
    xcopy "build\windows\x64\runner\Release\data" "releases\windows\data\" /E /I /Y
)

REM Create portable ZIP
cd releases\windows
powershell -command "Compress-Archive -Path '.\*' -DestinationPath '.\LocalizerApp-1.0.0-Portable.zip' -Force"
cd ..\..

echo.
echo Windows build completed successfully!
echo Portable app: releases\windows\LocalizerApp-1.0.0-Portable.zip
echo Executable: releases\windows\LocalizerApp.exe
echo.
pause