@echo off
cd /d "%~dp0..\releases\windows"

echo Creating portable ZIP package...
powershell -Command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem; $source = Get-Location; $destination = Join-Path $source 'LocalizerApp-1.0.0-Portable.zip'; if (Test-Path $destination) { Remove-Item $destination }; $compression = [System.IO.Compression.CompressionLevel]::Optimal; $includeBaseDirectory = $false; [System.IO.Compression.ZipFile]::CreateFromDirectory($source, $destination, $compression, $includeBaseDirectory) }"

if exist "LocalizerApp-1.0.0-Portable.zip" (
    echo ✓ ZIP package created successfully!
    dir "LocalizerApp-1.0.0-Portable.zip"
) else (
    echo ERROR: Failed to create ZIP package
)

pause