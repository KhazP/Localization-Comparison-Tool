@echo off
echo Testing Localization Comparison Tool Executable...
echo.

if not exist "releases\windows\LocalizerApp.exe" (
    echo ERROR: LocalizerApp.exe not found!
    echo Please run build_windows_final.bat first to create the executable.
    pause
    exit /b 1
)

echo Executable found. File information:
dir "releases\windows\LocalizerApp.exe"
echo.

echo Required DLL files:
if exist "releases\windows\flutter_windows.dll" (
    echo ✓ flutter_windows.dll
) else (
    echo ✗ flutter_windows.dll - MISSING!
)

if exist "releases\windows\desktop_drop_plugin.dll" (
    echo ✓ desktop_drop_plugin.dll
) else (
    echo ✗ desktop_drop_plugin.dll - MISSING!
)

if exist "releases\windows\libgit2-1.5.0.dll" (
    echo ✓ libgit2-1.5.0.dll
) else (
    echo ✗ libgit2-1.5.0.dll - MISSING!
)

if exist "releases\windows\libgit2dart_plugin.dll" (
    echo ✓ libgit2dart_plugin.dll
) else (
    echo ✗ libgit2dart_plugin.dll - MISSING!
)

if exist "releases\windows\data" (
    echo ✓ data directory
) else (
    echo ✗ data directory - MISSING!
)

echo.
echo Starting application for testing...
echo Press Ctrl+C in this window to stop the test.
echo Close the application window when done testing.
echo.

cd "releases\windows"
start "" "LocalizerApp.exe"

echo Application launched. 
echo - Test file selection (Browse buttons)
echo - Test drag & drop functionality  
echo - Test file comparison features
echo - Check all UI elements work properly
echo.
echo Close the application window when finished testing.
pause