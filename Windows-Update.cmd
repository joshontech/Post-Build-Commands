@echo off

PowerShell -command "if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}"

if %errorlevel%==1 (
    PowerShell -Command "Set-ExecutionPolicy Unrestricted -Force"
    set PowerShell-Enabled-At-Start=0
)  else ( 
    set PowerShell-Enabled-At-Start=1
)

cls

set counter=0
:loop
if %counter% lss 3 (
    echo.
    echo.
    echo Updates will start momentarilly...
    PowerShell -command "Install-PackageProvider -Name NuGet -Force" -WindowStyle Hidden > nul
    PowerShell -command "Install-Module -Name PSWindowsUpdate -Force" -WindowStyle Hidden > nul
    PowerShell -command "Import-Module -Name PSWindowsUpdate -Force" -WindowStyle Hidden > nul
    set /a counter+=1
    
)

cls

PowerShell -command "Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose -IgnoreReboot"
pause

REM Checking if Windows needs to be rebooted.
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" > nul
cls

if %errorlevel% equ 0 (
  set RebootRequired=1
) else (
  call :PowerShell-ExecutionPolicy-Check
  echo.
  echo.
  echo No reboot is required.
  pause
  call :DeleteNuGet
  exit /b
)

if %RebootRequired% equ 1 (
  echo.
  echo.
  echo Reboot is required after installing updates.
  set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "
)
if /i "%choice%" equ "Y" (
  call :PowerShell-ExecutionPolicy-Check
  call :DeleteNuGet
  shutdown /r /t 0
  exit /b
  
)   else (
      call :PowerShell-ExecutionPolicy-Check
      echo.
      echo.
      echo You may restart Windows at a later time.
      pause     
      call :DeleteNuGet
      exit /b
) 

:PowerShell-ExecutionPolicy-Check
if %PowerShell-Enabled-At-Start% equ 1 (
    call
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
)
exit /b

:DeleteNuget
  cd C:\Program Files\
  if exist PackageManagement (
    rmdir /s /q PackageManagement
 )   else (
      call
 )