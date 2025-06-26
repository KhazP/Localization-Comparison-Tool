@echo off
echo Manual Windows Build Process
echo =============================
echo.
echo This script will run each build step manually with pauses
echo so you can see exactly where any issues occur.
echo.
pause

echo Step 1: Check current directory
echo Current directory: %CD%
if not exist "pubspec.yaml" (
    echo ERROR: Not in Flutter project directory!
    pause
    exit /b 1
)
echo ✓ In correct directory
pause

echo.
echo Step 2: Check Flutter in PATH
where flutter
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter not found in PATH
    pause
    exit /b 1
)
echo ✓ Flutter found
pause

echo.
echo Step 3: Check Flutter doctor
flutter doctor
echo.
echo Check above output. Continue if no critical issues (red X marks).
pause

echo.
echo Step 4: Clean previous builds
flutter clean
echo ✓ Clean completed
pause

echo.
echo Step 5: Get dependencies
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: pub get failed
    pause
    exit /b 1
)
echo ✓ Dependencies retrieved
pause

echo.
echo Step 6: Generate code (may fail if not needed)
flutter packages pub run build_runner build --delete-conflicting-outputs
echo Code generation completed (errors here are often normal)
pause

echo.
echo Step 7: Build Windows app (this will take time)
echo Building... please wait...
flutter build windows --release
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Build failed!
    echo Check the error messages above.
    pause
    exit /b 1
)
echo ✓ Build completed successfully
pause

echo.
echo Step 8: Check for executable
if exist "build\windows\x64\runner\Release\localizer_app_main.exe" (
    echo ✓ Executable found!
    dir "build\windows\x64\runner\Release\localizer_app_main.exe"
) else (
    echo ERROR: Executable not found!
    echo Checking build directory:
    if exist "build" (
        dir /s build\*.exe
    )
    pause
    exit /b 1
)
pause

echo.
echo Step 9: Create releases directory
if not exist "releases\windows" mkdir "releases\windows"
echo ✓ Releases directory ready

echo.
echo Step 10: Copy files for distribution
copy "build\windows\x64\runner\Release\localizer_app_main.exe" "releases\windows\LocalizerApp.exe"
copy "build\windows\x64\runner\Release\*.dll" "releases\windows\"
if exist "build\windows\x64\runner\Release\data" (
    xcopy "build\windows\x64\runner\Release\data" "releases\windows\data\" /E /I /Y
)
echo ✓ Files copied

echo.
echo Step 11: Check final package
echo Files in releases\windows\:
dir "releases\windows\"

echo.
echo ========================================
echo MANUAL BUILD COMPLETED!
echo ========================================
echo.
echo Test the executable by running:
echo releases\windows\LocalizerApp.exe
echo.
pause