@echo off

:: Change directory to the location od dcu-cli to execute the program.
cd C:\Program Files\Dell\CommandUpdate


echo.
echo.
echo Checking for and installing Dell updates.
:: Command to run Dell Command Update to scan, download, and install needed updates.
dcu-cli /applyUpdates


::pause

echo.
echo.
set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "

if /i "%choice%"=="Y" (
  shutdown -r -t 0
) else (
  echo Restart cancelled.
  pause
)