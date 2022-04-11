function Test-DbaCmConnection {
    <#
    .SYNOPSIS
        Tests over which paths a computer can be managed.

    .DESCRIPTION
        Tests over which paths a computer can be managed.

        This function tries out the connectivity for:
        - Cim over WinRM
        - Cim over DCOM
        - Wmi
        - PowerShellRemoting
        Results will be written to the connectivity cache and will cause Get-DbaCmObject and Invoke-DbaCmMethod to connect using the way most likely to succeed. This way, it is likely the other commands will take less time to execute. These others too cache their results, in order to dynamically update connection statistics.

        This function ignores global configuration settings limiting which protocols may be used.

    .PARAMETER ComputerName
        The computer to test against.

    .PARAMETER Credential
        The credentials to use when running the test. Bad credentials are automatically cached as non-working. This behavior can be disabled by the 'Cache.Management.Disable.BadCredentialList' configuration.

    .PARAMETER Type
        The connection protocol types to test.
        By default, all types are tested.

        Note that this function will ignore global configurations limiting the types of connections available and test all connections specified here instead.

        Available connection protocol types: "CimRM", "CimDCOM", "Wmi", "PowerShellRemoting"

    .PARAMETER Force
        If this switch is enabled, the Alert will be dropped and recreated on Destination.

    .PARAMETER EnableException
        By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
        This avoids overwhelming you with "sea of red" exceptions, but is inconvenient because it basically disables advanced scripting.
        Using this switch turns this "nice by default" feature off and enables you to catch exceptions with your own try/catch.

    .NOTES
        Tags: ComputerManagement, CIM
        Author: Friedrich Weinmann (@FredWeinmann)

        Website: https://dbatools.io
        Copyright: (c) 2018 by dbatools, licensed under MIT
        License: MIT https://opensource.org/licenses/MIT

        **This function should not be called from within dbatools. It is meant as a tool for users only.**

    .LINK
        https://dbatools.io/Test-DbaCmConnection

    .EXAMPLE
        PS C:\> Test-DbaCmConnection -ComputerName sql2014

        Performs a full-spectrum connection test against the computer sql2014. The results will be reported and registered. Future calls from Get-DbaCmObject will recognize the results and optimize the query.

    .EXAMPLE
        PS C:\> Test-DbaCmConnection -ComputerName sql2014 -Credential $null -Type CimDCOM, CimRM

        This test will run a connectivity test of CIM over DCOM and CIM over WinRM against the computer sql2014 using Windows Authentication.

        The results will be reported and registered. Future calls from Get-DbaCmObject will recognize the results and optimize the query.
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWMICmdlet", "", Justification = "Using Get-WmiObject is used as a fallback for testing connections")]
    param (
        [Parameter(ValueFromPipeline)]
        [Sqlcollaborative.Dbatools.Parameter.DbaCmConnectionParameter[]]$ComputerName = $env:COMPUTERNAME,
        [PSCredential]$Credential,
        [Sqlcollaborative.Dbatools.Connection.ManagementConnectionType[]]$Type = @("CimRM", "CimDCOM", "Wmi", "PowerShellRemoting"),
        [switch]$Force,
        [switch]$EnableException
    )
    begin {
        #region Configuration Values
        $disable_cache = Get-DbatoolsConfigValue -Name "ComputerManagement.Cache.Disable.All" -Fallback $false
        #Variable marked as unused by PSScriptAnalyzer
        #$disable_badcredentialcache = Get-DbatoolsConfigValue -Name "ComputerManagement.Cache.Disable.BadCredentialList" -Fallback $false
        #endregion Configuration Values

        #region Helper Functions
        function Test-ConnectionCimRM {
            [CmdletBinding()]
            param (
                [Sqlcollaborative.Dbatools.Parameter.DbaCmConnectionParameter]
                $ComputerName,

                [System.Management.Automation.PSCredential]
                $Credential
            )

            try {
                #Variable $os marked as unused by PSScriptAnalyzer replace with $null to catch output
                $null = $ComputerName.Connection.GetCimRMInstance($Credential, "Win32_OperatingSystem", "root\cimv2")

                New-Object PSObject -Property @{
                    Success       = "Success"
                    Timestamp     = Get-Date
                    Authenticated = $true
                }
            } catch {
                if (($_.Exception.InnerException -eq 0x8007052e) -or ($_.Exception.InnerException -eq 0x80070005)) {
                    New-Object PSObject -Property @{
                        Success       = "Error"
                        Timestamp     = Get-Date
                        Authenticated = $false
                    }
                } else {
                    New-Object PSObject -Property @{
                        Success       = "Error"
                        Timestamp     = Get-Date
                        Authenticated = $true
                    }
                }
            }
        }

        function Test-ConnectionCimDCOM {
            [CmdletBinding()]
            param (
                [Sqlcollaborative.Dbatools.Parameter.DbaCmConnectionParameter]
                $ComputerName,

                [System.Management.Automation.PSCredential]
                $Credential
            )

            try {
                #Variable $os marked as unused by PSScriptAnalyzer replace with $null to catch output
                $null = $ComputerName.Connection.GetCimDComInstance($Credential, "Win32_OperatingSystem", "root\cimv2")

                New-Object PSObject -Property @{
                    Success       = "Success"
                    Timestamp     = Get-Date
                    Authenticated = $true
                }
            } catch {
                if (($_.Exception.InnerException -eq 0x8007052e) -or ($_.Exception.InnerException -eq 0x80070005)) {
                    New-Object PSObject -Property @{
                        Success       = "Error"
                        Timestamp     = Get-Date
                        Authenticated = $false
                    }
                } else {
                    New-Object PSObject -Property @{
                        Success       = "Error"
                        Timestamp     = Get-Date
                        Authenticated = $true
                    }
                }
            }
        }

        function Test-ConnectionWmi {
            [CmdletBinding()]
            param (
                [string]
                $ComputerName,

                [System.Management.Automation.PSCredential]
                $Credential
            )

            try {
                #Variable $os marked as unused by PSScriptAnalyzer replace with $null to catch output
                $null = Get-WmiObject -ComputerName $ComputerName -Credential $Credential -Class Win32_OperatingSystem -ErrorAction Stop
                New-Object PSObject -Property @{
                    Success       = "Success"
                    Timestamp     = Get-Date
                    Authenticated = $true
                }
            } catch [System.UnauthorizedAccessException] {
                New-Object PSObject -Property @{
                    Success       = "Error"
                    Timestamp     = Get-Date
                    Authenticated = $false
                }
            } catch {
                New-Object PSObject -Property @{
                    Success       = "Error"
                    Timestamp     = Get-Date
                    Authenticated = $true
                }
            }
        }

        function Test-ConnectionPowerShellRemoting {
            [CmdletBinding()]
            param (
                [string]
                $ComputerName,

                [System.Management.Automation.PSCredential]
                $Credential
            )

            try {
                $parameters = @{
                    ScriptBlock  = { Get-WmiObject -Class Win32_OperatingSystem -ErrorAction Stop }
                    ComputerName = $ComputerName
                    ErrorAction  = 'Stop'
                }
                if ($Credential) { $parameters["Credential"] = $Credential }
                #Variable $os marked as unused by PSScriptAnalyzer replace with $null to catch output
                $null = Invoke-Command @parameters

                New-Object PSObject -Property @{
                    Success       = "Success"
                    Timestamp     = Get-Date
                    Authenticated = $true
                }
            } catch {
                # Will always consider authenticated, since any call with credentials to a server that doesn't exist will also carry invalid credentials error.
                # There simply is no way to differentiate between actual authentication errors and server not reached
                New-Object PSObject -Property @{
                    Success       = "Error"
                    Timestamp     = Get-Date
                    Authenticated = $true
                }
            }
        }
        #endregion Helper Functions
    }
    process {
        foreach ($ConnectionObject in $ComputerName) {
            if (-not $ConnectionObject.Success) { Stop-Function -Message "Failed to interpret input: $($ConnectionObject.Input)" -Category InvalidArgument -Target $ConnectionObject.Input -Continue }

            $Computer = $ConnectionObject.Connection.ComputerName.ToLowerInvariant()
            Write-Message -Level VeryVerbose -Message "[$Computer] Testing management connection"

            #region Setup connection object
            $con = $ConnectionObject.Connection
            #endregion Setup connection object

            #region Handle credentials
            #Variable marked as unused by PSScriptAnalyzer
            #$BadCredentialsFound = $false
            if ($con.DisableBadCredentialCache) { $con.KnownBadCredentials.Clear() }
            elseif ($con.IsBadCredential($Credential) -and (-not $Force)) {
                Stop-Function -Message "[$Computer] The credentials supplied are on the list of known bad credentials, skipping. Use -Force to override this." -Continue -Category InvalidArgument -Target $Computer
            } elseif ($con.IsBadCredential($Credential) -and $Force) {
                $con.RemoveBadCredential($Credential)
            }
            #endregion Handle credentials

            #region Connectivity Tests
            :types foreach ($ConnectionType in $Type) {
                switch ($ConnectionType) {
                    #region CimRM
                    "CimRM" {
                        Write-Message -Level Verbose -Message "[$Computer] Testing management access using CIM over WinRM"
                        $res = Test-ConnectionCimRM -ComputerName $con -Credential $Credential
                        $con.LastCimRM = $res.Timestamp
                        $con.CimRM = $res.Success
                        Write-Message -Level VeryVerbose -Message "[$Computer] CIM over WinRM Results | Success: $($res.Success), Authentication: $($res.Authenticated)"

                        if (-not $res.Authenticated) {
                            Write-Message -Level Important -Message "[$Computer] The credentials supplied proved to be invalid. Skipping further tests"
                            $con.AddBadCredential($Credential)
                            break types
                        }
                    }
                    #endregion CimRM

                    #region CimDCOM
                    "CimDCOM" {
                        Write-Message -Level Verbose -Message "[$Computer] Testing management access using CIM over DCOM."
                        $res = Test-ConnectionCimDCOM -ComputerName $con -Credential $Credential
                        $con.LastCimDCOM = $res.Timestamp
                        $con.CimDCOM = $res.Success
                        Write-Message -Level VeryVerbose -Message "[$Computer] CIM over DCOM Results | Success: $($res.Success), Authentication: $($res.Authenticated)"

                        if (-not $res.Authenticated) {
                            Write-Message -Level Important -Message "[$Computer] The credentials supplied proved to be invalid. Skipping further tests."
                            $con.AddBadCredential($Credential)
                            break types
                        }
                    }
                    #endregion CimDCOM

                    #region Wmi
                    "Wmi" {
                        Write-Message -Level Verbose -Message "[$Computer] Testing management access using WMI."
                        $res = Test-ConnectionWmi -ComputerName $Computer -Credential $Credential
                        $con.LastWmi = $res.Timestamp
                        $con.Wmi = $res.Success
                        Write-Message -Level VeryVerbose -Message "[$Computer] WMI Results | Success: $($res.Success), Authentication: $($res.Authenticated)"

                        if (-not $res.Authenticated) {
                            Write-Message -Level Important -Message "[$Computer] The credentials supplied proved to be invalid. Skipping further tests"
                            $con.AddBadCredential($Credential)
                            break types
                        }
                    }
                    #endregion Wmi

                    #region PowerShell Remoting
                    "PowerShellRemoting" {
                        Write-Message -Level Verbose -Message "[$Computer] Testing management access using PowerShell Remoting."
                        $res = Test-ConnectionPowerShellRemoting -ComputerName $Computer -Credential $Credential
                        $con.LastPowerShellRemoting = $res.Timestamp
                        $con.PowerShellRemoting = $res.Success
                        Write-Message -Level VeryVerbose -Message "[$Computer] PowerShell Remoting Results | Success: $($res.Success)"
                    }
                    #endregion PowerShell Remoting
                }
            }
            #endregion Connectivity Tests

            if (-not $disable_cache) { [Sqlcollaborative.Dbatools.Connection.ConnectionHost]::Connections[$Computer] = $con }
            $con
        }
    }
    end {

    }
}
# SIG # Begin signature block
# MIIZewYJKoZIhvcNAQcCoIIZbDCCGWgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUs0IIqmM2ZQH5l7RwWLMteXRd
# wbGgghSJMIIE/jCCA+agAwIBAgIQDUJK4L46iP9gQCHOFADw3TANBgkqhkiG9w0B
# AQsFADByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFz
# c3VyZWQgSUQgVGltZXN0YW1waW5nIENBMB4XDTIxMDEwMTAwMDAwMFoXDTMxMDEw
# NjAwMDAwMFowSDELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMu
# MSAwHgYDVQQDExdEaWdpQ2VydCBUaW1lc3RhbXAgMjAyMTCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAMLmYYRnxYr1DQikRcpja1HXOhFCvQp1dU2UtAxQ
# tSYQ/h3Ib5FrDJbnGlxI70Tlv5thzRWRYlq4/2cLnGP9NmqB+in43Stwhd4CGPN4
# bbx9+cdtCT2+anaH6Yq9+IRdHnbJ5MZ2djpT0dHTWjaPxqPhLxs6t2HWc+xObTOK
# fF1FLUuxUOZBOjdWhtyTI433UCXoZObd048vV7WHIOsOjizVI9r0TXhG4wODMSlK
# XAwxikqMiMX3MFr5FK8VX2xDSQn9JiNT9o1j6BqrW7EdMMKbaYK02/xWVLwfoYer
# vnpbCiAvSwnJlaeNsvrWY4tOpXIc7p96AXP4Gdb+DUmEvQECAwEAAaOCAbgwggG0
# MA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsG
# AQUFBwMIMEEGA1UdIAQ6MDgwNgYJYIZIAYb9bAcBMCkwJwYIKwYBBQUHAgEWG2h0
# dHA6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAfBgNVHSMEGDAWgBT0tuEgHf4prtLk
# YaWyoiWyyBc1bjAdBgNVHQ4EFgQUNkSGjqS6sGa+vCgtHUQ23eNqerwwcQYDVR0f
# BGowaDAyoDCgLoYsaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJl
# ZC10cy5jcmwwMqAwoC6GLGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9zaGEyLWFz
# c3VyZWQtdHMuY3JsMIGFBggrBgEFBQcBAQR5MHcwJAYIKwYBBQUHMAGGGGh0dHA6
# Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBPBggrBgEFBQcwAoZDaHR0cDovL2NhY2VydHMu
# ZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hBMkFzc3VyZWRJRFRpbWVzdGFtcGluZ0NB
# LmNydDANBgkqhkiG9w0BAQsFAAOCAQEASBzctemaI7znGucgDo5nRv1CclF0CiNH
# o6uS0iXEcFm+FKDlJ4GlTRQVGQd58NEEw4bZO73+RAJmTe1ppA/2uHDPYuj1UUp4
# eTZ6J7fz51Kfk6ftQ55757TdQSKJ+4eiRgNO/PT+t2R3Y18jUmmDgvoaU+2QzI2h
# F3MN9PNlOXBL85zWenvaDLw9MtAby/Vh/HUIAHa8gQ74wOFcz8QRcucbZEnYIpp1
# FUL1LTI4gdr0YKK6tFL7XOBhJCVPst/JKahzQ1HavWPWH1ub9y4bTxMd90oNcX6X
# t/Q/hOvB46NJofrOp79Wz7pZdmGJX36ntI5nePk2mOHLKNpbh6aKLzCCBRowggQC
# oAMCAQICEAMFu4YhsKFjX7/erhIE520wDQYJKoZIhvcNAQELBQAwcjELMAkGA1UE
# BhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2lj
# ZXJ0LmNvbTExMC8GA1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIENvZGUg
# U2lnbmluZyBDQTAeFw0yMDA1MTIwMDAwMDBaFw0yMzA2MDgxMjAwMDBaMFcxCzAJ
# BgNVBAYTAlVTMREwDwYDVQQIEwhWaXJnaW5pYTEPMA0GA1UEBxMGVmllbm5hMREw
# DwYDVQQKEwhkYmF0b29sczERMA8GA1UEAxMIZGJhdG9vbHMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQC8v2N7q+O/vggBtpjmteofFo140k73JXQ5sOD6
# QLzjgija+scoYPxTmFSImnqtjfZFWmucAWsDiMVVro/6yGjsXmJJUA7oD5BlMdAK
# fuiq4558YBOjjc0Bp3NbY5ZGujdCmsw9lqHRAVil6P1ZpAv3D/TyVVq6AjDsJY+x
# rRL9iMc8YpD5tiAj+SsRSuT5qwPuW83ByRHqkaJ5YDJ/R82ZKh69AFNXoJ3xCJR+
# P7+pa8tbdSgRf25w4ZfYPy9InEvsnIRVZMeDjjuGvqr0/Mar73UI79z0NYW80yN/
# 7VzlrvV8RnniHWY2ib9ehZligp5aEqdV2/XFVPV4SKaJs8R9AgMBAAGjggHFMIIB
# wTAfBgNVHSMEGDAWgBRaxLl7KgqjpepxA8Bg+S32ZXUOWDAdBgNVHQ4EFgQU8MCg
# +7YDgENO+wnX3d96scvjniIwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsG
# AQUFBwMDMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNv
# bS9zaGEyLWFzc3VyZWQtY3MtZzEuY3JsMDWgM6Axhi9odHRwOi8vY3JsNC5kaWdp
# Y2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDBMBgNVHSAERTBDMDcGCWCG
# SAGG/WwDATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20v
# Q1BTMAgGBmeBDAEEATCBhAYIKwYBBQUHAQEEeDB2MCQGCCsGAQUFBzABhhhodHRw
# Oi8vb2NzcC5kaWdpY2VydC5jb20wTgYIKwYBBQUHMAKGQmh0dHA6Ly9jYWNlcnRz
# LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVkSURDb2RlU2lnbmluZ0NB
# LmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQCPzflwlQwf1jak
# EqymPOc0nBxiY7F4FwcmL7IrTLhub6Pjg4ZYfiC79Akz5aNlqO+TJ0kqglkfnOsc
# jfKQzzDwcZthLVZl83igzCLnWMo8Zk/D2d4ZLY9esFwqPNvuuVDrHvgh7H6DJ/zP
# Vm5EOK0sljT0UQ6HQEwtouH5S8nrqCGZ8jKM/+DeJlm+rCAGGf7TV85uqsAn5JqD
# En/bXE1AlyG1Q5YiXFGS5Sf0qS4Nisw7vRrZ6Qc4NwBty4cAYjzDPDixorWI8+FV
# OUWKMdL7tV8i393/XykwsccCstBCp7VnSZN+4vgzjEJQql5uQfysjcW9rrb/qixp
# csPTKYRHMIIFMDCCBBigAwIBAgIQBAkYG1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0B
# AQsFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVk
# IElEIFJvb3QgQ0EwHhcNMTMxMDIyMTIwMDAwWhcNMjgxMDIyMTIwMDAwWjByMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQg
# Q29kZSBTaWduaW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# +NOzHH8OEa9ndwfTCzFJGc/Q+0WZsTrbRPV/5aid2zLXcep2nQUut4/6kkPApfmJ
# 1DcZ17aq8JyGpdglrA55KDp+6dFn08b7KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0
# sSgmuyRpwsJS8hRniolF1C2ho+mILCCVrhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6s
# cKKrzn/pfMuSoeU7MRzP6vIK5Fe7SrXpdOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4Tz
# rGdOtcT3jNEgJSPrCGQ+UpbB8g8S9MWOD8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg
# 0A9kczyen6Yzqf0Z3yWT0QIDAQABo4IBzTCCAckwEgYDVR0TAQH/BAgwBgEB/wIB
# ADAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwMweQYIKwYBBQUH
# AQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYI
# KwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFz
# c3VyZWRJRFJvb3RDQS5jcnQwgYEGA1UdHwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0
# LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaG
# NGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
# QS5jcmwwTwYDVR0gBEgwRjA4BgpghkgBhv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0
# dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYE
# FFrEuXsqCqOl6nEDwGD5LfZldQ5YMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
# IZ3zbcgPMA0GCSqGSIb3DQEBCwUAA4IBAQA+7A1aJLPzItEVyCx8JSl2qB1dHC06
# GsTvMGHXfgtg/cM9D8Svi/3vKt8gVTew4fbRknUPUbRupY5a4l4kgU4QpO4/cY5j
# DhNLrddfRHnzNhQGivecRk5c/5CxGwcOkRX7uq+1UcKNJK4kxscnKqEpKBo6cSgC
# PC6Ro8AlEeKcFEehemhor5unXCBc2XGxDI+7qPjFEmifz0DLQESlE/DmZAwlCEIy
# sjaKJAL+L3J+HNdJRZboWR3p+nRka7LrZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4Gb
# T8aTEAb8B4H6i9r5gkn3Ym6hU/oSlBiFLpKR6mhsRDKyZqHnGKSaZFHvMIIFMTCC
# BBmgAwIBAgIQCqEl1tYyG35B5AXaNpfCFTANBgkqhkiG9w0BAQsFADBlMQswCQYD
# VQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
# aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgQ0Ew
# HhcNMTYwMTA3MTIwMDAwWhcNMzEwMTA3MTIwMDAwWjByMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgVGltZXN0YW1waW5n
# IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvdAy7kvNj3/dqbqC
# mcU5VChXtiNKxA4HRTNREH3Q+X1NaH7ntqD0jbOI5Je/YyGQmL8TvFfTw+F+CNZq
# FAA49y4eO+7MpvYyWf5fZT/gm+vjRkcGGlV+Cyd+wKL1oODeIj8O/36V+/OjuiI+
# GKwR5PCZA207hXwJ0+5dyJoLVOOoCXFr4M8iEA91z3FyTgqt30A6XLdR4aF5FMZN
# JCMwXbzsPGBqrC8HzP3w6kfZiFBe/WZuVmEnKYmEUeaC50ZQ/ZQqLKfkdT66mA+E
# f58xFNat1fJky3seBdCEGXIX8RcG7z3N1k3vBkL9olMqT4UdxB08r8/arBD13ays
# 6Vb/kwIDAQABo4IBzjCCAcowHQYDVR0OBBYEFPS24SAd/imu0uRhpbKiJbLIFzVu
# MB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMIMHkGCCsG
# AQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
# MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNl
# cnRBc3N1cmVkSURSb290Q0EuY3J0MIGBBgNVHR8EejB4MDqgOKA2hjRodHRwOi8v
# Y3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMDqg
# OKA2hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
# b290Q0EuY3JsMFAGA1UdIARJMEcwOAYKYIZIAYb9bAACBDAqMCgGCCsGAQUFBwIB
# FhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BTMAsGCWCGSAGG/WwHATANBgkq
# hkiG9w0BAQsFAAOCAQEAcZUS6VGHVmnN793afKpjerN4zwY3QITvS4S/ys8DAv3F
# p8MOIEIsr3fzKx8MIVoqtwU0HWqumfgnoma/Capg33akOpMP+LLR2HwZYuhegiUe
# xLoceywh4tZbLBQ1QwRostt1AuByx5jWPGTlH0gQGF+JOGFNYkYkh2OMkVIsrymJ
# 5Xgf1gsUpYDXEkdws3XVk4WTfraSZ/tTYYmo9WuWwPRYaQ18yAGxuSh1t5ljhSKM
# Ycp5lH5Z/IwP42+1ASa2bKXuh1Eh5Fhgm7oMLSttosR+u8QlK0cCCHxJrhO24XxC
# QijGGFbPQTS2Zl22dHv1VjMiLyI2skuiSpXY9aaOUjGCBFwwggRYAgEBMIGGMHIx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJ
# RCBDb2RlIFNpZ25pbmcgQ0ECEAMFu4YhsKFjX7/erhIE520wCQYFKw4DAhoFAKB4
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkE
# MRYEFPygIRVJ69Lw3v3V/Kfmkw8fdfvNMA0GCSqGSIb3DQEBAQUABIIBAAxdgF2B
# sDXJn0yIhqMr7Btf222bnFRXnHGTOyMhD+Iw47f4SWLUEMIDmJQZfU0743dIcMja
# R/tZtr9s+vrahdYTK5oQAbm/U8F/9ckNNTJzs1fo+BDFTQhs8vWxUZ9+c+c3K7yO
# qzZZGjgDVspAwceZZrO63EYyh3dXg7IPPoEQXwZV5wzlXdiDvIB61BRmG0kcYrpF
# OotRFFfkGQ1GyNlkWWJLPbCUzu1cWLO7fM3aHhy2+q/fM4zeP/LPaTs0oHEA/+fx
# EmI3OZr7daPOmRSGLoWyZhmLxbJcdyfLgXppIqpxEoxUafAqiWIQesPFW2jUEM33
# BwV5qpMb3zvRP02hggIwMIICLAYJKoZIhvcNAQkGMYICHTCCAhkCAQEwgYYwcjEL
# MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3
# LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElE
# IFRpbWVzdGFtcGluZyBDQQIQDUJK4L46iP9gQCHOFADw3TANBglghkgBZQMEAgEF
# AKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
# MDgxMTA4MjYwMFowLwYJKoZIhvcNAQkEMSIEIMhEENgdm4D6y5XZfRceMnubZuY2
# PtugGXPZ0tgeyTPeMA0GCSqGSIb3DQEBAQUABIIBALLaCMC+qejLQESKowXm2luR
# SPnX50zhxy6a1OLs5efTzjDabI/lcAyqc0lx39O2Uh/B3wJ/jafaTL+BxMMLhKsj
# sp9X7N6siXkChnI95p3gzMRYeHP8ONnHuA6WF2y2rPqAuqLYPbFBNm+flbgtKAMW
# JsXRYoK8sZAQ3xW/wyv5n/drmbTur9O7mdcTo/mui4n+OU/hb79A+a0qwpiVSLUv
# /gBu/LIJa60tffEhDdlU/EBbvrlhQ2pkIoGQV5E7waXhLZKrLgaltg1lxvWVSXXI
# 5L5cu/+Ks26MZHoyVuRcqcKJaGyNzSSdcf3O4ibLEmPYueu9V5I9YUHCMfzZOxk=
# SIG # End signature block
