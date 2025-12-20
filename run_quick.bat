@echo off
:: Quick launch - runs the app in debug mode immediately
cd /d "%~dp0"
echo Starting Localizer App...
flutter run -d windows
pause
