@echo off
setlocal EnableDelayedExpansion
pushd "%~dp0"

:: ============================================================================
::  LOCALIZER CLI - Modern / Minimalist
:: ============================================================================
title Localizer App

:: --- Unicode & Colors ---
for /f "tokens=2 delims=:" %%A in ('chcp') do set "OLDCP=%%A"
set "OLDCP=%OLDCP: =%"
chcp 65001 >nul

:: Detect PowerShell for reliable colored output and helper functions
where powershell >nul 2>&1
if %ERRORLEVEL%==0 (set "HAS_PS=1") else (set "HAS_PS=0")

:: Setup Colors (ANSI)
set "ESC="
if "%HAS_PS%"=="1" (
  for /f "delims=" %%A in ('powershell -NoProfile -Command "[char]27"') do set "ESC=%%A"
)
if defined WT_SESSION set "ESC= "
if "%ESC%"=="" set "ESC= "

:: If still empty, try to force it for standard cmd in Win10+
if "%ESC%"==" " for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

set "C_RESET=%ESC%[0m"
set "C_BOLD=%ESC%[1m"
set "C_DIM=%ESC%[2m"
set "C_ACCENT=%ESC%[36m"
set "C_SUCCESS=%ESC%[32m"
set "C_WARN=%ESC%[33m"
set "C_ERR=%ESC%[31m"
set "C_SUBTLE=%ESC%[90m"

:: --- Config ---
set "LOG_DIR=logs"
if not exist "%LOG_DIR%\" mkdir "%LOG_DIR%" >nul 2>&1

:: --- Checks ---
if not exist "pubspec.yaml" (
  call :Error "Project root not found" "Please run this from the folder containing pubspec.yaml"
  goto END
)

where flutter >nul 2>&1
if %ERRORLEVEL% neq 0 (
  call :Error "Flutter not found" "Please ensure Flutter is in your PATH."
  goto END
)

:MENU
cls
echo.
echo  %C_BOLD%Localizer App%C_RESET% %C_SUBTLE%CLI%C_RESET%
echo.

:: -- Version info --
for /f "tokens=2" %%V in ('flutter --version 2^>nul') do set "FLV=%%V"
if defined FLV echo  %C_ACCENT%•%C_RESET% Flutter %FLV%

where git >nul 2>&1
if %ERRORLEVEL%==0 (
  for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "BR=%%B"
  if defined BR echo  %C_ACCENT%•%C_RESET% %BR%
)
echo.

:: -- Menu Options --
echo  %C_SUBTLE%RUN%C_RESET%
echo   %C_BOLD%1%C_RESET%  Debug            %C_SUBTLE%... Hot Reload enabled%C_RESET%
echo   %C_BOLD%2%C_RESET%  Release          %C_SUBTLE%... Optimized performance%C_RESET%
echo.
echo  %C_SUBTLE%BUILD%C_RESET%
echo   %C_BOLD%3%C_RESET%  Windows Exe      %C_SUBTLE%... Production build%C_RESET%
echo.
echo  %C_SUBTLE%MAINTENANCE%C_RESET%
echo   %C_BOLD%4%C_RESET%  Clean            %C_SUBTLE%... Deep clean & cache clear%C_RESET%
echo   %C_BOLD%5%C_RESET%  Update           %C_SUBTLE%... Pub get%C_RESET%
echo   %C_BOLD%6%C_RESET%  Analyze          %C_SUBTLE%... Lint check%C_RESET%
echo.
echo  %C_SUBTLE%OTHER%C_RESET%
echo   %C_BOLD%7%C_RESET%  Doctor           %C_SUBTLE%... Environment check%C_RESET%
echo   %C_BOLD%8%C_RESET%  Logs             %C_SUBTLE%... Open log folder%C_RESET%
echo   %C_BOLD%0%C_RESET%  Exit
echo.

set "CHOICE="
set /p "CHOICE=%C_ACCENT%~%C_RESET% "

if /I "%CHOICE%"=="1" goto CMD_DEBUG
if /I "%CHOICE%"=="2" goto CMD_RELEASE
if /I "%CHOICE%"=="3" goto CMD_BUILD
if /I "%CHOICE%"=="4" goto CMD_CLEAN
if /I "%CHOICE%"=="5" goto CMD_UPDATE
if /I "%CHOICE%"=="6" goto CMD_ANALYZE
if /I "%CHOICE%"=="7" goto CMD_DOCTOR
if /I "%CHOICE%"=="8" goto CMD_LOGS
if /I "%CHOICE%"=="0" goto END

goto MENU

:: ============================================================================
:: ACTIONS
:: ============================================================================

:CMD_DEBUG
cls
call :Banner "Starting Debug Session..."
flutter run -d windows
goto :MENU

:CMD_RELEASE
cls
call :Banner "Starting Release Build..."
flutter run -d windows --release
goto :MENU

:CMD_BUILD
cls
call :Banner "Building Windows Executable..."
call :LogRun "Build Windows" "flutter build windows --release"
if %ERRORLEVEL%==0 (
  echo.
  echo  %C_SUCCESS%Build Successful!%C_RESET%
  set "OUT=build\windows\x64\runner\Release"
  if exist "!OUT!" start "" explorer "!OUT!"
) else (
  call :Error "Build Failed" "Check the logs for details."
)
pause
goto MENU

:CMD_CLEAN
cls
call :Banner "Deep Clean..."
echo  %C_WARN%Target:%C_RESET% build\ + .dart_tool\
echo.
choice /C YN /N /M "Are you sure? [Y/N] "
if errorlevel 2 goto MENU

echo.
echo  %C_SUBTLE%Cleaning project...%C_RESET%
flutter clean >nul 2>&1
if exist "build\" rmdir /s /q "build"
if exist ".dart_tool\" rmdir /s /q ".dart_tool"
echo  %C_SUCCESS%Done.%C_RESET%
timeout /t 1 /nobreak >nul
goto MENU

:CMD_UPDATE
cls
call :Banner "Updating Dependencies..."
call :LogRun "Pub Get" "flutter pub get"
pause
goto MENU

:CMD_ANALYZE
cls
call :Banner "Running Analysis..."
flutter analyze
echo.
pause
goto MENU

:CMD_DOCTOR
cls
call :Banner "Flutter Doctor..."
flutter doctor -v
echo.
pause
goto MENU

:CMD_LOGS
if exist "%LOG_DIR%" start "" explorer "%CD%\%LOG_DIR%"
goto MENU

:END
if defined OLDCP chcp %OLDCP% >nul
popd
exit /b 0

:: ============================================================================
:: HELPERS
:: ============================================================================

:Banner
echo.
echo  %C_ACCENT%::%C_RESET% %C_BOLD%%~1%C_RESET%
echo.
exit /b 0

:LogRun
:: %1 = Name, %2 = Command
echo  %C_SUBTLE%Running: %~2%C_RESET%
echo.
call :GetDateStr
set "LOGf=%LOG_DIR%\%~1_%DT%.log"
%~2 > "%LOGf%" 2>&1
if %ERRORLEVEL%==0 (
   echo  %C_SUCCESS%Success%C_RESET%
) else (
   echo  %C_ERR%Failed (Exit Code: %ERRORLEVEL%)%C_RESET%
   echo  %C_WARN%See log: %LOGf%%C_RESET%
   echo.
   echo  --- Last 10 lines ---
   if "%HAS_PS%"=="1" (
     powershell -NoProfile -Command "Get-Content -Path '%LOGf%' -Tail 10"
   ) else (
     type "%LOGf%"
   )
)
exit /b 0

:Error
echo.
echo  %C_ERR%Error:%C_RESET% %~1
echo  %~2
echo.
pause
exit /b 0

:GetDateStr
:: Generates clean timestamp in DT variable
if "%HAS_PS%"=="1" (
  for /f "delims=" %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "DT=%%T"
) else (
  set "DT=%DATE%_%TIME%"
  set "DT=!DT: =_!"
  set "DT=!DT:/=-!"
  set "DT=!DT::=-!"
  set "DT=!DT:.=-!"
)
exit /b 0
