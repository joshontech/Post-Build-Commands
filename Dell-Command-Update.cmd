@echo off

:: BatchGotAdmin
:-------------------------------------
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
powershell -command "Start-Process -FilePath '%0' -Verb RunAs"
exit /B

:gotAdmin
:: Continue with the script's main logic
pushd "%~dp0"
:--------------------------------------

echo.
echo Checking for 64 bit Dell Command Update...
timeout /t 3 /nobreak > nul

:: Sets the variable folder_path to the folder path of Dell Command Update.
set "folder_path=C:\Program Files\Dell\CommandUpdate"

:: Checks if the folder path to Dell Command Update exists.
:: If the folder path does not exist it prints the echo message below.
:: If the folder path does exist than it skips to next command.
if not exist "%folder_path%" (
    echo.
    echo 64 bit Dell Command Update is not installed.
    echo Please install 64 bit Dell Command Update.
    pause
    call
)     else (
        echo.
        echo Dell Command Update is installed.
        timeout /t 3 /nobreak > nul
        call
)

:: Change directory to the location of dcu-cli to execute the program.
cd C:\Program Files\Dell\CommandUpdate

echo.
echo Checking for and installing Dell updates.
:: Command to run Dell Command Update to scan, download, and install needed updates.
.\dcu-cli.exe /driverInstall

.\dcu-cli.exe /scan

.\dcu-cli.exe /applyUpdates

:: Checks for return code 500 which means the system is up to date.
:: If the return code is 500 it prints the echo message below.
:: If the return code is not 500 then it skips to the next command.
if %errorlevel%==500 (
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

:: Prints the question below and checks to see if the variable choice is Y.
:: If choice is Y than the computer restarts.
:: IF chose is anything other than Y it will skip the restart command.
  set /p choice="Windows will need to restart. Would you like to restart Windows now? (Y/N) "
  if /i "%choice%"=="Y" (
    shutdown -r -t 0
)     else (
        echo.
        echo.
        echo You may restart Windows at a later time.
        pause
)


