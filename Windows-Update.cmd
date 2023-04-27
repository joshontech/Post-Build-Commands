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

PowerShell -command "if((Get-ExecutionPolicy ) -eq 'Restricted') {exit 1}"

if %errorlevel% == 1 (
    PowerShell -Command "Set-ExecutionPolicy Unrestricted -Force"
    set PowerShell-Enabled-At-Start=0
)  else ( 
    set PowerShell-Enabled-At-Start=1
)

echo %PowerShell-Enabled-At-Start%
pause
cls

echo.
echo Updates will start momentarilly...
PowerShell -command "Install-PackageProvider -Name NuGet -Force" > nul 2>&1
PowerShell -command "Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.0.3 -Force"
PowerShell -command "Import-Module -Name PSWindowsUpdate -Force"
cls

PowerShell -command "Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot -Verbose"

PowerShell -command "Uninstall-Module -Name PSWindowsUpdate -Force"

call :PowerShell-ExecutionPolicy-Check
call :DeleteNuget

:: Checking if Windows needs to be rebooted.
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" > nul 2>&1
if %errorlevel% == 0 (
    set endgame=1
) else (
    set endgame=0
)

:: Checking if Windows needs to be rebooted.
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations" > nul 2>&1
if %errorlevel% == 0 (
    set endgame=1
) else (
    set endgame=0
)

echo %endgame%
pause

if %endgame% == 1 (
  set RebootRequired=1
) else if %endgame% == 0 (
  echo.
  echo.
  echo No reboot is required.
  pause
  exit /b
)

if %RebootRequired% == 1 (
  echo.
  echo.
  echo Reboot is required after installing updates.
  set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "
)
if /i "%choice%" == "Y" (
  shutdown /r /t 0
  exit /b
) else (
    echo.
    echo.
    echo You may restart Windows at a later time.
    pause
    exit /b
) 

:: Functions
:---------------------------------------------------------------------------
:UninstallModule
  PowerShell -command "Uninstall-Module -Name PSWindowsUpdate -Force" > nul 2>&1
  exit /b
  
:PowerShell-ExecutionPolicy-Check                                          
  if %PowerShell-Enabled-At-Start% == 1 (
    exit /b
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
    exit /b
)

:DeleteNuget
  setlocal
  set folder=C:\Program Files\PackageManagement

  if exist "%folder%" (
    rmdir /s /q "%folder%"
    exit /b
  )
:----------------------------------------------------------------------------