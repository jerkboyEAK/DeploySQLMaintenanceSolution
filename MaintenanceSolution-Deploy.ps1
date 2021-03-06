<#

SQL Server Maintenance Solution deployment script.

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
#>

[CmdletBinding()]
param (
   [Parameter (Mandatory = $true)]
   [string]$Computer,

   [Parameter (Mandatory = $false)]
   [string]$Instance,

   [Parameter (Mandatory = $false)]
   [string]$InstallSourcePath = "\\$env:COMPUTERNAME\SQLMaintenanceSolutionDeploy",

   [Parameter (Mandatory = $false)]
   [System.Management.Automation.PSCredential]
   $InstallCredential = $host.ui.promptForCredential("Install Credential", "Please specify the credential used for service installation", $env:username, $env:USERDOMAIN)
)

If ($Instance.Length -EQ 0) {
   $SqlSvrInstance = $Computer
   $Instance = 'MSSQLSERVER'
}
else {
   $SqlSvrInstance = "$Computer\$Instance"
}

Import-Module -Name dbatools

Write-Verbose "Starting SQL Maintenance Solution Configuration"

Write-Verbose "Create standard maintenance jobs - https://ola.hallengren.com/downloads.html"
#needed to move to Invoke-SqlCMD instead of Invoke-DBAQuery due to an issue where the Maintenance solution script is too large
Invoke-Sqlcmd -ServerInstance $SqlSvrInstance -Database master -InputFile "$InstallSourcePath\scripts\MaintenanceSolution.sql"
Invoke-Sqlcmd -ServerInstance $SqlSvrInstance -Database master -InputFile "$InstallSourcePath\scripts\MaintenanceSolution-Configuration.sql"
Invoke-Sqlcmd -ServerInstance $SqlSvrInstance -Database master -InputFile "$InstallSourcePath\scripts\MaintenanceSolution-Scheduling.sql"


Write-Verbose "Restart SQL Service to ensure all settings take effect"
Set-DbaCmConnection -ComputerName $Computer -OverrideExplicitCredential
Restart-DbaService -ComputerName $Computer -InstanceName $Instance -Type Engine -Credential $InstallCredential -Force

Write-Verbose "Completed SQL Maintenance Solution Configuration"