@echo off

cd C:\Program Files\
if exist PackageManagement (
  rmdir /s /q PackageManagement
)   else (
      call
)
exit