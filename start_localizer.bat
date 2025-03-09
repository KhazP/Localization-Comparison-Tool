@echo off
setlocal enabledelayedexpansion

:: Application metadata
set APP_NAME=Localization Comparison Tool
set APP_VERSION=0.5
set APP_AUTHOR=KhazP
set MIN_PYTHON_VERSION=3.8

:: Set console appearance
color 0A
title %APP_NAME% v%APP_VERSION% - %APP_AUTHOR%
cls

:: Log file setup
set LOG_DIR=%~dp0logs
set LOG_FILE=%LOG_DIR%\localizer_app_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

:: Start header
echo.
echo   ==================================================
echo   #                                                #
echo   #       LOCALIZATION COMPARISON TOOL             #
echo   #                  v%APP_VERSION%                        #
echo   #              Created by %APP_AUTHOR%                  #
echo   #                                                #
echo   ==================================================
echo.

:: Log start time
set START_TIME=%TIME%
echo %date% %time% - Application started > "%LOG_FILE%" 2>&1

:: Set the current directory to the script location
cd /d "%~dp0"
echo   [%TIME:~0,8%] Starting up from %CD%...

:: Verify admin rights if needed
REM net session >nul 2>&1
REM if %ERRORLEVEL% NEQ 0 (
REM     color 0E
REM     echo   [%TIME:~0,8%] WARNING: Not running with administrator privileges
REM     echo   Some features may not work correctly.
REM     echo.
REM )

:: Check Python is installed
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo   [%TIME:~0,8%] ERROR: Python is not installed or not in PATH >> "%LOG_FILE%" 2>&1
    echo   [%TIME:~0,8%] ERROR: Python is not installed or not in PATH
    echo   Please install Python %MIN_PYTHON_VERSION% or later and try again.
    echo.
    echo   Press any key to exit...
    pause > nul
    exit /b 1
)

:: Check Python version is sufficient
for /f "tokens=2" %%I in ('python --version 2^>^&1') do (
    set PYTHON_VERSION=%%I
    echo   [%TIME:~0,8%] Detected Python version: !PYTHON_VERSION! >> "%LOG_FILE%" 2>&1
    echo   [%TIME:~0,8%] Detected Python version: !PYTHON_VERSION!
)

:: Check required dependencies and install missing ones
echo   [%TIME:~0,8%] Checking dependencies...

:: Array of required packages
set REQUIRED_PACKAGES=flet darkdetect pillow
for %%P in (%REQUIRED_PACKAGES%) do (
    python -c "import %%P" >nul 2>&1 || (
        echo   [%TIME:~0,8%] Installing required package: %%P
        echo   [%TIME:~0,8%] Installing required package: %%P >> "%LOG_FILE%" 2>&1
        pip install %%P >> "%LOG_FILE%" 2>&1
    )
)

:: Set PYTHONPATH to include the project root directory
set PYTHONPATH=%~dp0
echo   [%TIME:~0,8%] Environment configured

:: Check for updates (can be replaced with your update mechanism)
echo   [%TIME:~0,8%] Checking for updates...
echo   [%TIME:~0,8%] Running latest version

echo.
echo   [%TIME:~0,8%] Launching application...
echo   ==================================================
echo.

:: Run the application with proper path and redirect stderr to log file
echo %date% %time% - Launching application... >> "%LOG_FILE%" 2>&1
python GUI\flet_gui.py >> "%LOG_FILE%" 2>&1
set EXIT_CODE=%ERRORLEVEL%

:: Handle errors
if %EXIT_CODE% NEQ 0 (
    color 0E
    echo.
    echo   [%TIME:~0,8%] WARNING: Application exited with code %EXIT_CODE%
    echo   If you're experiencing issues, check the logs at:
    echo   %LOG_FILE%
    echo   Or contact support at: alpyalay@gmail.com
    echo %date% %time% - Application exited with code %EXIT_CODE% >> "%LOG_FILE%" 2>&1
) else (
    echo %date% %time% - Application exited normally >> "%LOG_FILE%" 2>&1
)

:: Calculate runtime
set END_TIME=%TIME%
echo   [%TIME:~0,8%] Application closed

echo   ==================================================
echo   #                                                #
echo   #  Thank you for using Localization Tool!        #
echo   #                - %APP_AUTHOR% -                       #
echo   #                                                #
echo   ==================================================
echo.
echo   Press any key to exit...
pause > nul
endlocal
exit /b %EXIT_CODE%