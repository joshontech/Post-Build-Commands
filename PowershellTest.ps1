


if((Get-ExecutionPolicy ) -ne 'Unrestricted') {exit 1}



if ($LASTEXITCODE -eq 1) {
    Set-ExecutionPolicy Unrestricted -Force
    $env:PowershellEnabledAtStart = 0
} else {
    $env:PowershellEnabledAtStart = 1
}



Install-PackageProvider -Name NuGet -Force


Install-Module -Name PSWindowsUpdate -Force


Import-Module -Name PSWindowsUpdate -Force


Get-WindowsUpdate -Install -MicrosoftUpdate -AcceptAll -Verbose



WindowsUpdate = Get-WindowsUpdate
if ($WindowsUpdate.RebootRequired) {
    Write-Host "A reboot is required."
}
else {
    Write-Host "A reboot is not required."
}



if ($PowershellEnabledAtStart -eq 1) {
    Set-ExecutionPolicy Unrestricted -Force
} else {
    Set-ExecutionPolicy Restricted -Force
}




Write-Host "Press any key to continue..."
$null = Read-Host

pause

