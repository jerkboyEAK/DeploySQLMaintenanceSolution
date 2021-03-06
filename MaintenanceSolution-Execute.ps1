<#
 .SYNOPSIS

 SQL Server Maintenance Solution deployment execution script.

 .DESCRIPTION
 ###########################################################
 Copyright (C) 2021 Microsoft Corporation

    Disclaimer:
    This is SAMPLE code that is NOT production ready. It is the sole intention of this code to provide a proof of concept as a
    learning tool for Microsoft Customers. Microsoft does not provide warranty for or guarantee any portion of this code
    and is NOT responsible for any affects it may have on any system it is executed on or environment it resides within.
    Please use this code at your own discretion!

    Additional legalese:

    This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment.
    THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED ""AS IS"" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
    INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
    We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute
    the object code form of the Sample Code, provided that You agree:
    (i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded;
    (ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and
    (iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys' fees,
    that arise or result from the use or distribution of the Sample Code.
 ###########################################################

 .INPUTS

 -Computer [string[]] - Defaults to localhost

 [-Instance <string>] - If provided will install SQL in an instance, otherwise default instance is used.

 [-InstallSourcePath <string>] - Path to installation base. Should be a UNC Path such as \\server\SQLInstallation

 -InstallCredential <psCredential> - Credential used to install SQL Server and perform all configurations. Account should be a member of the group specified in -DBATeamGroup as well as a local administrator of the target server.

 .EXAMPLE

 .\MaintenanceSolution-Execute.ps1 -Computer computer1 -Instance INST1 -InstallSourcePath '\\computerShare\SQLInstall'

 .NOTES

 This script makes some directory assumptions:
 1. All required PowerShell modules required for this script are present in the PSModules sub-folder.
 3. All post deployment scripts can be found in the Scripts sub-folder.
 #>

param (
    [Parameter (Mandatory = $true)]
    [string[]]$Computer = 'localhost',

    [Parameter (Mandatory = $false)]
    [string]$Instance,

    [Parameter (Mandatory = $false)]
    [string]$InstallSourcePath = "\\$env:COMPUTERNAME\SQLMaintenanceSolutionDeploy",
        
    [Parameter (Mandatory = $false)]
    [System.Management.Automation.PSCredential]
    $InstallCredential = $host.ui.promptForCredential("Install Credential", "Please specify the credential used for service installation", $env:USERNAME, $env:USERDOMAIN)
)

$scriptVersion = '1.0.0'
$InstallDate = Get-Date -Format "yyyy-mm-dd HH:mm:ss K"
$StartTime = $(Get-Date)

##########################################
#begin validation of parameters

#Set working directory
[string]$scriptPath = $MyInvocation.MyCommand.Path
[string]$Dir = Split-Path $scriptPath

Import-Module $dir\helperFunctions\AccountVerifications.psm1
Import-Module $dir\helperFunctions\DirectoryVerifications.psm1
Import-Module $dir\helperFunctions\Tools.psm1

# check install credential is valid
<#IF ($null -eq $InstallCredential) {
    Write-Warning "User clicked cancel at credential prompt."
    Break
}
ELSE {
    if ((Test-AccountCredential -Credential $InstallCredential) -eq $false) {
        $valid = $false
    }
}#>

# test reach target computer(s)
FOREACH ($c in $Computer) {
    IF (!(Test-Connection -ComputerName $c -Quiet)) {
        Write-Warning "Unable to connect to $c"
        $valid = $false
    }
}

# test you can reach installation media
IF (!(Test-Path $InstallSourcePath)) {
    Write-Warning "Unable to connect to $InstallSourcePath"
    $valid = $false
}


##########################################
# end of validations...  if any tests fail, quit
if ($valid -eq $false) {
    break
}

foreach ($c in $Computer) {
    #Run SQLInstanceConfiguration.ps1
    If ($Instance.Length -EQ 0) {
        .\MaintenanceSolution-Deploy.ps1 -Computer $c -InstallSourcePath $InstallSourcePath -InstallCredential $InstallCredential
    }
    else {
        .\MaintenanceSolution-Deploy.ps1 -Computer $c -Instance $Instance -InstallSourcePath $InstallSourcePath -InstallCredential $InstallCredential
    }
}

$elapsedTime = $(Get-Date) - $StartTime
$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
Write-Host "Installation duration: $totalTime"