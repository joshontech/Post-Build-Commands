@echo off

echo.
echo.
echo Starting Script.


PowerShell -command "if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}"


if %errorlevel%==1 (
    PowerShell -Command "Set-ExecutionPolicy Unrestricted -Force"
    set PowerShell-Enabled-At-Start=0
)  else ( 
    set PowerShell-Enabled-At-Start=1
)

PowerShell -command "Install-PackageProvider -Name NuGet -Force"
cls

PowerShell -command "Install-Module -Name PSWindowsUpdate -Force"
cls

PowerShell -command "Import-Module -Name PSWindowsUpdate -Force"
cls

echo.
echo.
echo Installing Windows Updates.
PowerShell -command "Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose -IgnoreReboot"
cls

REM Checking if Windows needs to be rebooted.
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" >nul
cls

if %errorlevel%==0 (
  set RebootRequired=1
) else (
  echo.
  echo.
  echo No reboot is required.
  pause
)

if %RebootRequired%==1 (
  echo.
  echo.
  echo Reboot is required after installing updates.
  set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "
)
if /i "%choice%"=="Y" (
      shutdown /r /t 0
) else (
    echo.
    echo.
    echo You may restart Windows at a later time.
    pause     
) 

if %PowerShell-Enabled-At-Start%==1 (
    call
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
)





