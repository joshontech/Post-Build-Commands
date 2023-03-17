@echo off

set "folder_path=C:\Program Files\Dell\CommandUpdate"

if not exist "%folder_path%" (
    echo.
    echo.  
    echo 64 bit Dell Command Update is not installed.
    echo Please install 64 bit Dell Command Update.
    pause
    exit /b 1 
)     else (
        call
)

:: Change directory to the location od dcu-cli to execute the program.
cd C:\Program Files\Dell\CommandUpdate

echo.
echo.
echo Checking for and installing Dell updates.
:: Command to run Dell Command Update to scan, download, and install needed updates.
dcu-cli /applyUpdates

if %errorlevel% == 500 (
   echo.
   echo. 
   echo No updates needed.
   pause
   goto :EOF
)   else (
      call
)
  echo.
  echo.
  set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "
  if /i "%choice%"=="Y" (
  shutdown -r -t 0
) else (
    echo.
    echo.
    echo Restart cancelled.
    pause
)


