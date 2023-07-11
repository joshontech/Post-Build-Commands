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
    echo.
    echo Please wait, installing Dell Command Update now...
    .\DCU-4.8.exe /s
    cls
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
if not exist "DCU-Driver-Package-installed.txt" (
  .\dcu-cli.exe /driverInstall
  break>DCU-Driver-Package-installed.txt
) else (
    .\dcu-cli.exe /scan
    .\dcu-cli.exe /applyUpdates
)

:: Checks for return code 500 which means the system is up to date.
:: If the return code is 500 or 0 (both meaning no updates needed) it prints the echo message below.
:: If the return code is not 500 or 0 then it skips to the next command.
if %errorlevel%==500 (
   echo.
   echo. 
   echo No updates needed.
   pause
   goto :EOF
)   else if %errorlevel%==0 (
      echo.
      echo.
      echo No updates needed.
      pause
      goto :EOF
:: Sometimes DCU gets stuck and displays error 3003 (Dell client management service is busy). In this case it needs to be force quit and re-ran.
)   else if %errorlevel%==3003 (
      echo.
      echo.
      echo The Dell Client Management Service is busy. Please wait for it to finish or kill the process and run this script again.
      pause
      goto :EOF
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


