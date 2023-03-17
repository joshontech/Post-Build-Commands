@echo off

echo.
echo.
echo Starting Script.
cls

powershell -command "if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}"

if %errorlevel% == 1 (
    powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
    set Powershell-Enabled-At-Start=0
) else ( 
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

if %Powershell-Enabled-At-Start% == 1 (
    call
) else (
    PowerShell -Command "Set-ExecutionPolicy Restricted -Force"
)