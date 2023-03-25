@echo off

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v RebootRequired /t REG_DWORD /d 0 /f

echo Registry value created.

pause

exit