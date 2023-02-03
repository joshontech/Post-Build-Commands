@echo off

:: Change directory to the location od dcu-cli to execute the program.
cd C:\Program Files\Dell\CommandUpdate


echo.
echo.
echo Checking for and installing Dell updates.
:: Command to run Dell Command Update to scan, download, and install needed updates.
dcu-cli /applyUpdates
echo.

pause
