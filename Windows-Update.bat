@echo off

powershell -command "Install-PackageProvider -Name NuGet -Force"
cls

powershell -command "Install-Module -Name PSWindowsUpdate -Force"
powershell -command "Import-Module -Name PSWindowsUpdate -Force"

echo.
echo.
echo Downloading Windows Updates.
powershell -command "Get-WindowsUpdate -Download -MicrosoftUpdate -AcceptAll -Verbose"

echo.
echo.
echo Installing Windows Updates.
powershell -command "Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose"
pause