@echo off
::PowerShell -ExecutionPolicy Bypass -File ".\PowershellTest.ps1"
PowerShell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-File .\PowershellTest.ps1'"
pause