@echo off

echo.
echo.
echo Starting Script.
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
pause