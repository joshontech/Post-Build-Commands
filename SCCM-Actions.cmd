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

echo Starting Script.
cls


echo Application Deployment Evaluation Cycle
echo 1 of 13
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000121}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 2 of 13
echo Discovery Data Collection Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000003}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 3 of 13
echo File Collection Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000010}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 4 of 13
echo Hardware Inventory Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000001}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 5 of 13
echo Machine Policy Retrieval Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000021}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 6 of 13
echo Machine Policy Evaluation Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000022}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 7 of 13
echo Software Inventory Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000002}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 8 of 13
echo Software Metering Usage Report Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000031}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 9 of 13
echo Software Updates Assignments Evaluation Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000108}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 10 of 13
echo Software Update Scan Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000113}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 11 of 13
echo User Policy Retrieval Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000026}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 12 of 13
echo User Policy Evaluation Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000027}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls

echo 13 of 13
echo Windows Installers Source List Update Cycle
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000032}" /NOINTERACTIVE
timeout /t 1 /nobreak > nul
cls