@echo off
:: Language: Batch, file: Run-Setup-As-Admin.bat, target: Windows 11
:: Memeriksa hak Administrator dan meminta elevasi jika belum
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Meminta hak Administrator...
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
echo ========================================================
echo   Windows 11 Personal Setup - Automated Administrator Runner
echo ========================================================
echo.

echo 1. Menjalankan Privacy and System Tweaks...
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\apply-system-tweaks.ps1"
echo.

echo 2. Menjalankan Debloat Appx & Provisioned Packages...
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\debloat-apps.ps1"
echo.

echo 3. Memperbarui Group Policy...
gpupdate /force
echo.

echo ========================================================
echo   Selesai! Silakan restart PC Anda untuk hasil optimal.
echo ========================================================
pause
