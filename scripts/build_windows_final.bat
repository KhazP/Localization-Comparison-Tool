@echo off
echo ========================================
echo Localization Comparison Tool - Windows Build
echo ========================================
echo.

echo Building Windows executable and creating distribution packages...
echo.

REM Step 1: Clean and prepare
echo [1/6] Cleaning previous builds...
flutter clean >nul 2>nul

REM Step 2: Get dependencies
echo [2/6] Getting dependencies...
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to get dependencies
    pause
    exit /b 1
)

REM Step 3: Generate code
echo [3/6] Generating required code...
flutter packages pub run build_runner build --delete-conflicting-outputs >nul 2>nul

REM Step 4: Build Windows app
echo [4/6] Building Windows application (this may take a few minutes)...
flutter build windows --release
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

REM Step 5: Create portable package
echo [5/6] Creating portable package...

REM Create releases directory
if not exist "releases\windows" mkdir "releases\windows"

REM Clean old files
if exist "releases\windows\LocalizerApp.exe" del "releases\windows\LocalizerApp.exe"
if exist "releases\windows\*.dll" del "releases\windows\*.dll"
if exist "releases\windows\data" rmdir /s /q "releases\windows\data"
if exist "releases\windows\LocalizerApp-1.0.0-Portable.zip" del "releases\windows\LocalizerApp-1.0.0-Portable.zip"

REM Copy files
copy "build\windows\x64\runner\Release\localizer_app_main.exe" "releases\windows\LocalizerApp.exe" >nul
copy "build\windows\x64\runner\Release\*.dll" "releases\windows\" >nul
xcopy "build\windows\x64\runner\Release\data" "releases\windows\data\" /E /I /Y >nul

REM Create ZIP package
cd releases\windows
powershell -Command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem; $files = @('LocalizerApp.exe', 'flutter_windows.dll', 'desktop_drop_plugin.dll', 'libgit2-1.5.0.dll', 'libgit2dart_plugin.dll', 'data'); $destination = 'LocalizerApp-1.0.0-Portable.zip'; if (Test-Path $destination) { Remove-Item $destination }; $zip = [System.IO.Compression.ZipFile]::Open($destination, 'Create'); foreach ($file in $files) { if (Test-Path $file) { if ((Get-Item $file) -is [System.IO.DirectoryInfo]) { Get-ChildItem $file -Recurse | ForEach-Object { $relativePath = $_.FullName.Substring((Get-Location).Path.Length + 1); if (-not $_.PSIsContainer) { [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $relativePath) } } } else { [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file, $file) } } }; $zip.Dispose() }"
cd ..\..

REM Step 6: Create installer (optional)
echo [6/6] Creating installer...
where iscc >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Creating professional installer with Inno Setup...
    iscc "scripts\windows_installer.iss" >nul 2>nul
    if %ERRORLEVEL% EQU 0 (
        echo ✓ Installer created successfully!
    ) else (
        echo ! Installer creation failed (continuing...)
    )
) else (
    echo ! Inno Setup not found - skipping installer creation
    echo   Install from: https://jrsoftware.org/isinfo.php
)

echo.
echo ========================================
echo BUILD COMPLETED SUCCESSFULLY!
echo ========================================
echo.
echo Distribution files created:
echo.

REM Show created files
if exist "releases\windows\LocalizerApp.exe" (
    echo ✓ Standalone Executable:
    for %%F in ("releases\windows\LocalizerApp.exe") do echo    LocalizerApp.exe ^(%%~zF bytes^)
    echo.
)

if exist "releases\windows\LocalizerApp-1.0.0-Portable.zip" (
    echo ✓ Portable Package:
    for %%F in ("releases\windows\LocalizerApp-1.0.0-Portable.zip") do echo    LocalizerApp-1.0.0-Portable.zip ^(%%~zF bytes^)
    echo.
)

if exist "releases\windows\LocalizerApp-1.0.0-Setup.exe" (
    echo ✓ Professional Installer:
    for %%F in ("releases\windows\LocalizerApp-1.0.0-Setup.exe") do echo    LocalizerApp-1.0.0-Setup.exe ^(%%~zF bytes^)
    echo.
)

echo Total files in releases\windows\:
dir /b "releases\windows\" | find /c /v ""
echo.

echo USAGE:
echo - For end users: Distribute LocalizerApp-1.0.0-Setup.exe (installer)
echo - For portable use: Distribute LocalizerApp-1.0.0-Portable.zip
echo - For testing: Run releases\windows\LocalizerApp.exe directly
echo.

echo All files are ready for distribution!
echo.
pause