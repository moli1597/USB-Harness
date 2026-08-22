@echo off
rem =============================================================================
rem  launch.bat - USB Harness launcher (Windows, double-click entry)
rem  Thin ASCII wrapper that calls scripts\launch-windows.ps1 (Chinese menu).
rem =============================================================================
setlocal
cd /d "%~dp0"

where powershell >nul 2>nul
if errorlevel 1 goto :no_pwsh

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\launch-windows.ps1" %*
exit /b %errorlevel%

:no_pwsh
echo [ERROR] PowerShell not found. Windows 10/11 includes it by default.
pause
exit /b 1
