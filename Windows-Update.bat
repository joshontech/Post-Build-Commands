@echo off

echo Starting Script.

powershell -command "Install-PackageProvider -Name NuGet -Force"


powershell -command "Install-Module -Name PSWindowsUpdate -Force"


powershell -command "Import-Module -Name PSWindowsUpdate -Force"
cls

echo.
echo.
echo Installing Windows Updates.
powershell -command "Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose"
pause