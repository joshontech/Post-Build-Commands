@echo off

echo.
echo.
echo Starting Script.


powershell -command "if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}"


if %errorlevel%==1 (
    powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
    set Powershell-Enabled-At-Start=0
)  else ( 
    set Powershell-Enabled-At-Start=1
)

powershell -command "Set-ExecutionPolicy Unrestricted -Force"
cls

powershell -command "Install-PackageProvider -Name NuGet -Force"
cls

powershell -command "Install-Module -Name PSWindowsUpdate -Force"
cls

powershell -command "Import-Module -Name PSWindowsUpdate -Force"
cls

echo.
echo.
echo Installing Windows Updates.
powershell -command "Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose"

:: Checking if Windows needs to be rebooted.
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" >nul 2>&1
if %errorlevel%==0 (
    echo.
    echo.
    echo Reboot required to apply updates.
) else (
    echo.
    echo.
    echo No reboot required.
)

if %Powershell-Enabled-At-Start%==1 (
    call
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
)
pause