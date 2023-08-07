<#
.SYNOPSIS
Downloads and deploys troubleshooting tools 
.DESCRIPTION
Downloads and deploys troubleshooting tools
.INPUTS
None required
.OUTPUTS
None required
.NOTES
  Version:        0.1
  Author:         PRE
  Linkedin:       https://www.linkedin.com/in/pascal-reimann-b66698230/
  Creation Date:  12/10/2022
  Updated Date:   12/10/2022
  Purpose/Change: Initial script development
  Change:         -
  
.EXAMPLE
N/A
#>

##Create a folder to store everything
$SupportTools = "C:\ProgramData\SupportTools"
If (Test-Path $toolsfolder) {
    Write-Output "$toolsfolder exists. Skipping."
}
Else {
    Write-Output "The folder '$SupportTools' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$SupportTools" -ItemType Directory
    Write-Output "The folder $SupportTools was successfully created."
}
##To install scripts
set-executionpolicy remotesigned -Force

##Set download locations
$cmtraceoutput = "C:\ProgramData\SupportTools\cmtrace.exe"

##Force install NuGet (no popups)
install-packageprovider -Name NuGet -MinimumVersion 2.8.5.201 -Force

##Force install Autopilot Diagnostics (no popups)
Install-Script -Name Get-AutopilotDiagnostics -Force

##Download CMTrace
Invoke-WebRequest `
-Uri "https://github.com/moskovskayax3/Support-Tools/raw/main/Tools/cmtrace.exe" `
-OutFile $cmtraceoutput `
-UseBasicParsing `
-Headers @{"Cache-Control"="no-cache"}

##Setup Complete
Write-Host "Setup Complete"
