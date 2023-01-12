@echo off


::                             _    _      _                             _                              _____           _       _    
::                            | |  | |    | |                           | |                            /  ___|         (_)     | |   
::                            | |  | | ___| | ___ ___  _ __ ___   ___   | |_ ___     _ __ ___  _   _   \ `--.  ___ _ __ _ _ __ | |_  
::                            | |/\| |/ _ \ |/ __/ _ \| '_ ` _ \ / _ \  | __/ _ \   | '_ ` _ \| | | |   `--. \/ __| '__| | '_ \| __| 
::                            \  /\  /  __/ | (_| (_) | | | | | |  __/  | || (_) |  | | | | | | |_| |  /\__/ / (__| |  | | |_) | |_  
::                             \/  \/ \___|_|\___\___/|_| |_| |_|\___|   \__\___/   |_| |_| |_|\__, |  \____/ \___|_|  |_| .__/ \__| 
::                                                                                              __/ |                    | |         
::                                                                                             |___/                     |_|         




::Disables ipv6 for all network adapters.
::echo Disabling ipv6
::reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 0xFFFFFFFF /f 
::echo.
::timeout /t 3 /nobreak > nul

::Only use the above if ipv6 is an issue. In the past only OPP needed to disable ipv6 but this can be used for anything that needs ipv6 disabled.
        
        

    echo.
    echo.
    echo.
            CALL :ProgressMeter 0
    echo Starting Script

        timeout /t 3 /nobreak > nul
    cls

    echo.
    echo.
    echo.
:: Disk cleanup utility to cleanup unneeded files.
    echo 1 of 9
    echo Cleaning up unneeded files.
    cleanmgr /sagerun:1
    echo.

            CALL :ProgressMeter 1
            CALL :ProgressMeter 2
            CALL :ProgressMeter 3
            CALL :ProgressMeter 4
            CALL :ProgressMeter 5
            CALL :ProgressMeter 6
            CALL :ProgressMeter 7
            CALL :ProgressMeter 8
            CALL :ProgressMeter 9
            CALL :ProgressMeter 10
    cls

    echo.
    echo.
    echo.

:: Adds psu domain for GlobalProtect to registry.
    echo 2 of 9
    echo Adding GlobalProtect prelogon to registry
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup\PreLogonState" /v ConnectedGateway /t REG_SZ /d prelogon.eg.secure-connect.psu.edu /f
    echo.

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 10
            CALL :ProgressMeter 11
            CALL :ProgressMeter 12
            CALL :ProgressMeter 13
            CALL :ProgressMeter 14
            CALL :ProgressMeter 15
            CALL :ProgressMeter 16
            CALL :ProgressMeter 17
            CALL :ProgressMeter 18
            CALL :ProgressMeter 19
            CALL :ProgressMeter 20
        
    cls

    echo.
    echo.
    echo.

:: Sets GlobalProtect logon state to 0.
    echo 3 of 9
    echo Setting GlobalProtect logon state to 0
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup\PreLogonState" /v LogonState /t REG_SZ /d 0 /f
    echo.

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 21
            CALL :ProgressMeter 22
            CALL :ProgressMeter 23
            CALL :ProgressMeter 24
            CALL :ProgressMeter 25
            CALL :ProgressMeter 26
            CALL :ProgressMeter 27
            CALL :ProgressMeter 28
            CALL :ProgressMeter 29
            CALL :ProgressMeter 30
    cls

    echo.
    echo.
    echo.

:: Disables Hibernation.
    echo 4 of 9
    echo Disabling Hibernation.
    powercfg -h off
    echo.

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 31
            CALL :ProgressMeter 32
            CALL :ProgressMeter 33
            CALL :ProgressMeter 34
            CALL :ProgressMeter 35
            CALL :ProgressMeter 36
            CALL :ProgressMeter 37
            CALL :ProgressMeter 38
            CALL :ProgressMeter 39
            CALL :ProgressMeter 40
    cls

    echo.
    echo.
    echo.

:: Sets screen and sleep timeout when using battery.
    echo 5 of 9
    echo Setting PC sleep to 30 minutes when using battery power.
    powercfg /change standby-timeout-dc 30

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 41
            CALL :ProgressMeter 42
            CALL :ProgressMeter 43
            CALL :ProgressMeter 44
            CALL :ProgressMeter 45
            CALL :ProgressMeter 46
            CALL :ProgressMeter 47
            CALL :ProgressMeter 48
            CALL :ProgressMeter 49
            CALL :ProgressMeter 50
    cls

    echo.
    echo.
    echo.

    echo 6 of 9
    echo Setting screen timeout to 30 minutes.
    powercfg /change monitor-timeout-dc 30
    

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 51
            CALL :ProgressMeter 52
            CALL :ProgressMeter 53
            CALL :ProgressMeter 54
            CALL :ProgressMeter 55
            CALL :ProgressMeter 56
            CALL :ProgressMeter 57
            CALL :ProgressMeter 58
            CALL :ProgressMeter 59
            CALL :ProgressMeter 60
    cls

    echo.
    echo.
    echo.

:: Sets screen and sleep timeout when plugged in.
    echo 7 of 9
    echo Disabling sleep.
    powercfg /change standby-timeout-ac 0

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 61
            CALL :ProgressMeter 62
            CALL :ProgressMeter 63
            CALL :ProgressMeter 64
            CALL :ProgressMeter 65
            CALL :ProgressMeter 66
            CALL :ProgressMeter 67
            CALL :ProgressMeter 68
            CALL :ProgressMeter 69
            CALL :ProgressMeter 70
    cls

    echo.
    echo.
    echo.

    echo 8 of 9
    echo Setting screen timeout to 1 hour when plugged into power.
    powercfg /change monitor-timeout-ac 60
    echo.

        timeout /t 3 /nobreak > nul
            CALL :ProgressMeter 71
            CALL :ProgressMeter 72
            CALL :ProgressMeter 73
            CALL :ProgressMeter 74
            CALL :ProgressMeter 75
            CALL :ProgressMeter 76
            CALL :ProgressMeter 77
            CALL :ProgressMeter 78
            CALL :ProgressMeter 79
            CALL :ProgressMeter 80
    cls

    echo.
    echo.
    echo.

:: Updates the group policy.
    echo 9 of 9
    echo Updating group policy.
    gpupdate /force
    echo.

        
            CALL :ProgressMeter 81
            CALL :ProgressMeter 82
            CALL :ProgressMeter 83
            CALL :ProgressMeter 84
            CALL :ProgressMeter 85
            CALL :ProgressMeter 86
            CALL :ProgressMeter 87
            CALL :ProgressMeter 88
            CALL :ProgressMeter 89
            CALL :ProgressMeter 90
        timeout /t 3 /nobreak > nul  
    cls

    echo.
    echo.
    echo.


echo Script Complete!
        ::timeout /t 1 /nobreak > nul
            CALL :ProgressMeter 91
            CALL :ProgressMeter 92
            CALL :ProgressMeter 93
            CALL :ProgressMeter 94
            CALL :ProgressMeter 95
            CALL :ProgressMeter 96
            CALL :ProgressMeter 97
            CALL :ProgressMeter 98
            CALL :ProgressMeter 99
            CALL :ProgressMeter 100

pause

:ProgressMeter
SETLOCAL ENABLEDELAYEDEXPANSION
SET ProgressPercent=%1
SET /A NumBars=%ProgressPercent%/2
SET /A NumSpaces=50-%NumBars%

SET Meter=

FOR /L %%A IN (%NumBars%,-1,1) DO SET Meter=!Meter!I
FOR /L %%A IN (%NumSpaces%,-1,1) DO SET Meter=!Meter!

TITLE Progress:  [%Meter%]  %ProgressPercent%%%
ENDLOCAL
GOTO :EOF