





if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}

Install-PackageProvider -Name NuGet -Force
Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.0.3 -Force
Import-Module -Name PSWindowsUpdate -Force

Get-WindowsUpdate -Install -AcceptAll -Verbose -IgnoreReboot





















