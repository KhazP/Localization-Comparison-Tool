@echo off
REM Setup script for pre-commit hooks
REM Run this once to install the hooks

echo =========================================
echo  LocalizerApp Pre-commit Hooks Setup
echo =========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH.
    echo Please install Python from https://python.org
    exit /b 1
)

REM Check if pre-commit is installed
python -m pre_commit --version >nul 2>&1
if errorlevel 1 (
    echo Installing pre-commit...
    pip install pre-commit
    if errorlevel 1 (
        echo ERROR: Failed to install pre-commit
        exit /b 1
    )
)

echo.
echo Installing git hooks...
python -m pre_commit install
python -m pre_commit install --hook-type commit-msg
python -m pre_commit install --hook-type pre-push

echo.
echo =========================================
echo  Setup Complete!
echo =========================================
echo.
echo Hooks installed:
echo   - pre-commit: format, analyze, pubspec check
echo   - commit-msg: conventional commit validation
echo   - pre-push: run tests before pushing
echo.
echo To run hooks manually on all files:
echo   python -m pre_commit run --all-files
echo.
echo To skip hooks temporarily (not recommended):
echo   git commit --no-verify
echo.
pause
