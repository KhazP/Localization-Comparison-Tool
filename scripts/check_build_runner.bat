@echo off
setlocal

set "log_file=%TEMP%\build_runner_check.log"

dart run build_runner build --delete-conflicting-outputs > "%log_file%" 2>&1
set "runner_exit=%errorlevel%"

type "%log_file%"

if not "%runner_exit%"=="0" exit /b %runner_exit%

findstr /C:"Nothing to do" "%log_file%" >nul
if %errorlevel%==0 exit /b 0

echo WARNING: Generated files may be out of date!
exit /b 1
