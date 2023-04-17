@echo off

:: BatchGotAdmin
:----------------------------------------------------------------
:: Check if the script is running with administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :gotAdmin
) else (
    echo Requesting administrative privileges...
    goto :UACPrompt
)

:UACPrompt
:: Elevate the script to run with administrator privileges
powershell Start-Process -FilePath "%0" -Verb RunAs
exit /B

:gotAdmin
:: Continue with the script's main logic
pushd "%~dp0"
:----------------------------------------------------------------

PowerShell -Command "Set-ExecutionPolicy Unrestricted -Scope Process -Force"

echo.
echo Updates will start momentarilly...
PowerShell -command "Install-PackageProvider -Name NuGet -Force" > nul 2>&1
PowerShell -command "Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.0.3 -Force"
PowerShell -command "Import-Module -Name PSWindowsUpdate -Force"
cls

PowerShell -command "Get-WindowsUpdate -Install -AcceptAll -Verbose"
pause
cls

echo.
echo.
echo Cleaning Up...

PowerShell -command "Uninstall-Module -Name PSWindowsUpdate -Force"

cd C:\Program Files

rmdir /s /q PackageManagement

exit