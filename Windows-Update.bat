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
powershell -command "Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose -IgnoreReboot"

:: Checking if Windows needs to be rebooted.
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" >nul 2>&1
if %errorlevel%==0 (
    echo.
    echo.
    set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "
    if /i {%choice%}=={Y} (
        shutdown -r -t 0
    )  else (
        echo.
        echo.
        echo You may restart Windows at a later time.
        pause
    )
) else (
    echo.
    echo.
    echo No reboot required.
    pause
)

if %Powershell-Enabled-At-Start%==1 (
    call
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
)