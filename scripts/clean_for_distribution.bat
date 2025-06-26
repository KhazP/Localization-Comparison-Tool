@echo off
echo Cleaning project for distribution build...
echo.

echo [1/4] Cleaning Flutter build cache...
flutter clean

echo [2/4] Removing any existing Hive database files...
for /r %%i in (*.hive) do (
    echo Deleting: %%i
    del "%%i" 2>nul
)

for /r %%i in (*.lock) do (
    echo Deleting: %%i
    del "%%i" 2>nul
)

echo [3/4] Clearing releases directory...
if exist "releases\windows" (
    echo Removing old distribution files...
    rd /s /q "releases\windows" 2>nul
    mkdir "releases\windows"
)

echo [4/4] Clearing any cached application data...
if exist "%LOCALAPPDATA%\localizer_app_main" (
    echo Removing cached app data...
    rd /s /q "%LOCALAPPDATA%\localizer_app_main" 2>nul
)

echo.
echo ✓ Project cleaned for distribution build
echo Now run: scripts\build_windows_final.bat
echo.
pause