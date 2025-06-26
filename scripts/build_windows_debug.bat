@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Building Localization Comparison Tool for Windows
echo ========================================
echo.

REM Enable error handling
set "errorlevel="

REM Check if we're in the right directory
if not exist "pubspec.yaml" (
    echo ERROR: pubspec.yaml not found. Please run this script from the project root directory.
    echo Current directory: %CD%
    pause
    exit /b 1
)

echo [1/8] Checking Flutter installation...
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter not found in PATH.
    echo Please ensure Flutter is installed and added to your system PATH.
    echo Visit: https://flutter.dev/docs/get-started/install/windows
    pause
    exit /b 1
)

REM Get Flutter version for debugging
echo Flutter found. Getting version info...
flutter --version
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: Could not get Flutter version, but continuing...
)

echo.
echo [2/8] Checking Flutter doctor status...
flutter doctor --verbose
echo.

echo [3/8] Cleaning previous builds...
if exist "build" (
    echo Removing existing build directory...
    rmdir /s /q "build" 2>nul
)
if exist ".dart_tool" (
    echo Removing .dart_tool directory...
    rmdir /s /q ".dart_tool" 2>nul
)

echo Running flutter clean...
flutter clean
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter clean failed with error code %ERRORLEVEL%
    pause
    exit /b 1
)

echo [4/8] Getting dependencies...
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter pub get failed with error code %ERRORLEVEL%
    pause
    exit /b 1
)

echo [5/8] Generating required code...
flutter packages pub run build_runner build --delete-conflicting-outputs
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Code generation failed with error code %ERRORLEVEL%
    echo This might be normal if no code generation is needed.
    echo Continuing with build...
)

echo [6/8] Building Windows release...
echo This may take several minutes...
flutter build windows --release --verbose
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter build windows failed with error code %ERRORLEVEL%
    echo.
    echo Please check the output above for specific error messages.
    echo Common issues:
    echo - Visual Studio with C++ tools not installed
    echo - Windows SDK not installed
    echo - Antivirus blocking build process
    pause
    exit /b 1
)

echo [7/8] Checking build output...
set "BUILD_PATH=build\windows\x64\runner\Release"
if not exist "%BUILD_PATH%\localizer_app_main.exe" (
    echo ERROR: Build completed but executable not found at expected location.
    echo Expected: %BUILD_PATH%\localizer_app_main.exe
    echo.
    echo Checking build directory contents:
    if exist "build" (
        dir /s build\*.exe
    ) else (
        echo Build directory does not exist.
    )
    pause
    exit /b 1
)

echo SUCCESS: Executable found at %BUILD_PATH%\localizer_app_main.exe
echo File size:
dir "%BUILD_PATH%\localizer_app_main.exe"

echo [8/8] Creating portable package...
if not exist "releases\windows" mkdir "releases\windows"

REM Remove old files
echo Cleaning previous releases...
if exist "releases\windows\LocalizerApp.exe" del "releases\windows\LocalizerApp.exe"
if exist "releases\windows\*.dll" del "releases\windows\*.dll"
if exist "releases\windows\data" rmdir /s /q "releases\windows\data"

REM Copy executable and rename
echo Copying executable...
copy "%BUILD_PATH%\localizer_app_main.exe" "releases\windows\LocalizerApp.exe"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to copy executable
    pause
    exit /b 1
)

REM Copy all DLLs
echo Copying required DLLs...
copy "%BUILD_PATH%\*.dll" "releases\windows\"
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: Some DLLs might not have been copied
)

REM Copy data directory if it exists
if exist "%BUILD_PATH%\data" (
    echo Copying data directory...
    xcopy "%BUILD_PATH%\data" "releases\windows\data\" /E /I /Y
)

REM List all copied files
echo.
echo Files in releases\windows\:
dir "releases\windows\"

echo.
echo Creating portable ZIP package...
cd releases\windows
powershell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('.', 'LocalizerApp-1.0.0-Portable.zip', 'Optimal', $false)}"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create ZIP package
    cd ..\..
    pause
    exit /b 1
)
cd ..\..

echo.
echo ========================================
echo BUILD COMPLETED SUCCESSFULLY!
echo ========================================
echo.
echo Files created:
echo - Executable:  releases\windows\LocalizerApp.exe
echo - Portable ZIP: releases\windows\LocalizerApp-1.0.0-Portable.zip
echo.
echo File sizes:
dir "releases\windows\LocalizerApp.exe"
dir "releases\windows\LocalizerApp-1.0.0-Portable.zip"
echo.
echo You can now run the executable directly or distribute the ZIP file.
echo.
pause