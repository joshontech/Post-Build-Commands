@echo off

echo.
echo.
echo Starting Script.


powershell -command "if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}"


if %errorlevel% == 1 (
    powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
    set Powershell-Enabled-At-Start=0
)       else ( 
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
powershell -command "if((Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose).RequiresReboot {exit 2}"

echo.
echo.
if %errorlevel% != 2 (
    echo No Reboot Needed.
    timeout /t 5 /nobreak > nul
)       else %errorlevel% == 1 ( 
            call
)       else if %errorlevel% == 0 (
            call
)

if %Powershell-Enabled-At-Start% == 1 (
    call
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
)