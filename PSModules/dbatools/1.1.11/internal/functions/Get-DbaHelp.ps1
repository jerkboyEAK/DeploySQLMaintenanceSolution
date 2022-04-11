function Get-DbaHelp {
    <#
    .SYNOPSIS
        Massages inline help data to a more useful format

    .DESCRIPTION
        Takes the inline help and outputs a more usable object

    .PARAMETER Name
        The function/command to extract help from

    .PARAMETER OutputAs
        Output format (raw PSObject or MDString)

    .NOTES
    Author: Simone Bizzotto (@niphlod)

    Website: https://dbatools.io
    Copyright: (c) 2018 by dbatools, licensed under MIT
    License: MIT https://opensource.org/licenses/MIT

    .LINK
        https://dbatools.io/Get-DbaHelp


    .EXAMPLE
        Get-DbaHelp Get-DbaDatabase

        Parses the inline help from Get-DbaDatabase and outputs the massaged object

    .EXAMPLE
        Get-DbaHelp Get-DbaDatabase -OutputAs "PSObject"

        Parses the inline help from Get-DbaDatabase and outputs the massaged object

    .EXAMPLE
        PS C:\> Get-DbaHelp Get-DbaDatabase -OutputAs "MDString" | Out-File Get-DbaDatabase.md
        PS C:\> & code Get-DbaDatabase.md

        Parses the inline help from Get-DbaDatabase as MarkDown, saves the file and opens it
        via VSCode

    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [string]$Name,

        [ValidateSet("PSObject", "MDString")]
        [string]$OutputAs = "PSObject"
    )

    begin {
        function Get-DbaTrimmedString($Text) {
            return $Text.Trim() -replace '(\r\n){2,}', "`n"
        }

        $tagsRex = ([regex]'(?m)^[\s]{0,15}Tags:(.*)$')
        $authorRex = ([regex]'(?m)^[\s]{0,15}Author:(.*)$')
        $minverRex = ([regex]'(?m)^[\s]{0,15}MinimumVersion:(.*)$')
        $maxverRex = ([regex]'(?m)^[\s]{0,15}MaximumVersion:(.*)$')
        $availability = 'Windows, Linux, macOS'

        function Get-DbaDocsMD($doc_to_render) {

            $rtn = New-Object -TypeName "System.Collections.ArrayList"
            $null = $rtn.Add("# $($doc_to_render.CommandName)" )
            if ($doc_to_render.Author -or $doc_to_render.Availability) {
                $null = $rtn.Add('|  |  |')
                $null = $rtn.Add('| - | - |')
                if ($doc_to_render.Author) {
                    $null = $rtn.Add('|  **Author**  | ' + $doc_to_render.Author.replace('|', ',') + ' |')
                }
                if ($doc_to_render.Availability) {
                    $null = $rtn.Add('| **Availability** | ' + $doc_to_render.Availability + ' |')
                }
                $null = $rtn.Add('')
            }
            $null = $rtn.Add("`n" + '&nbsp;' + "`n")
            if ($doc_to_render.Alias) {
                $null = $rtn.Add('')
                $null = $rtn.Add('*Aliases : ' + $doc_to_render.Alias + '*')
                $null = $rtn.Add('')
            }
            $null = $rtn.Add('## Synopsis')
            $null = $rtn.Add($doc_to_render.Synopsis)
            $null = $rtn.Add('')
            $null = $rtn.Add('## Description')
            $null = $rtn.Add($doc_to_render.Description)
            $null = $rtn.Add('')
            if ($doc_to_render.Syntax) {
                $null = $rtn.Add('## Syntax')
                $null = $rtn.Add('```')
                $splitted_paramsets = @()
                foreach ($val in ($doc_to_render.Syntax -split $doc_to_render.CommandName)) {
                    if ($val) {
                        $splitted_paramsets += $doc_to_render.CommandName + $val
                    }
                }
                foreach ($syntax in $splitted_paramsets) {
                    $x = 0
                    foreach ($val in ($syntax.Replace("`r", '').Replace("`n", '') -split ' \[')) {
                        if ($x -eq 0) {
                            $null = $rtn.Add($val)
                        } else {
                            $null = $rtn.Add('    [' + $val.replace("`n", '').replace("`n", ''))
                        }
                        $x += 1
                    }
                    $null = $rtn.Add('')
                }

                $null = $rtn.Add('```')
                $null = $rtn.Add("`n" + '&nbsp;' + "`n")
            }
            $null = $rtn.Add('')
            $null = $rtn.Add('## Examples')
            $null = $rtn.Add("`n" + '&nbsp;' + "`n")
            $examples = $doc_to_render.Examples.Replace("`r`n", "`n") -replace '(\r\n){2,8}', '\n'
            $examples = $examples.replace("`r", '').split("`n")
            $inside = 0
            foreach ($row in $examples) {
                if ($row -like '*----') {
                    $null = $rtn.Add("");
                    $null = $rtn.Add('#####' + ($row -replace '-{4,}([^-]*)-{4,}', '$1').replace('EXAMPLE', 'Example: '))
                } elseif (($row -like 'PS C:\>*') -or ($row -like '>>*')) {
                    if ($inside -eq 0) { $null = $rtn.Add('```') }
                    $null = $rtn.Add(($row.Trim() -replace 'PS C:\\>\s*', "PS C:\> "))
                    $inside = 1
                } elseif ($row.Trim() -eq '' -or $row.Trim() -eq 'Description') {

                } else {
                    if ($inside -eq 1) {
                        $inside = 0
                        $null = $rtn.Add('```')
                    }
                    $null = $rtn.Add("$row<br>")
                }
            }
            if ($inside -eq 1) {
                $inside = 0
                $null = $rtn.Add('```')
            }
            if ($doc_to_render.Params) {
                $dotitle = 0
                $filteredparams = @()
                foreach ($p in $doc_to_render.Params) {
                    if ($p[3] -eq $true) {
                        $filteredparams += , $p
                    }
                }
                $dotitle = 0
                foreach ($el in $filteredparams) {
                    if ($dotitle -eq 0) {
                        $dotitle = 1
                        $null = $rtn.Add('### Required Parameters')
                    }
                    $null = $rtn.Add('##### -' + $el[0])
                    $null = $rtn.Add($el[1] + '<br>')
                    $null = $rtn.Add('')
                    $null = $rtn.Add('|  |  |')
                    $null = $rtn.Add('| - | - |')
                    $null = $rtn.Add('| Alias | ' + $el[2] + ' |')
                    $null = $rtn.Add('| Required | ' + $el[3] + ' |')
                    $null = $rtn.Add('| Pipeline | ' + $el[4] + ' |')
                    $null = $rtn.Add('| Default Value | ' + $el[5] + ' |')
                    if ($el[6]) {
                        $null = $rtn.Add('| Accepted Values | ' + $el[6] + ' |')
                    }
                    $null = $rtn.Add('')
                }
                $dotitle = 0
                $filteredparams = @()
                foreach ($p in $doc_to_render.Params) {
                    if ($p[3] -eq $false) {
                        $filteredparams += , $p
                    }
                }
                foreach ($el in $filteredparams) {
                    if ($dotitle -eq 0) {
                        $dotitle = 1
                        $null = $rtn.Add('### Optional Parameters')
                    }

                    $null = $rtn.Add('##### -' + $el[0])
                    $null = $rtn.Add($el[1] + '<br>')
                    $null = $rtn.Add('')
                    $null = $rtn.Add('|  |  |')
                    $null = $rtn.Add('| - | - |')
                    $null = $rtn.Add('| Alias | ' + $el[2] + ' |')
                    $null = $rtn.Add('| Required | ' + $el[3] + ' |')
                    $null = $rtn.Add('| Pipeline | ' + $el[4] + ' |')
                    $null = $rtn.Add('| Default Value | ' + $el[5] + ' |')
                    if ($el[6]) {
                        $null = $rtn.Add('| Accepted Values | ' + $el[6] + ' |')
                    }
                    $null = $rtn.Add('')
                }
            }
            $null = $rtn.Add('')
            $null = $rtn.Add("`n" + '&nbsp;' + "`n")
            $null = $rtn.Add('Want to see the source code for this command? Check out [' + $doc_to_render.CommandName + '](https://github.com/sqlcollaborative/dbatools/blob/master/functions/' + $doc_to_render.CommandName + '.ps1) on GitHub.')
            $null = $rtn.Add("<br>")
            $null = $rtn.Add('Want to see the Bill Of Health for this command? Check out [' + $doc_to_render.CommandName + '](https://sqlcollaborative.github.io/boh#' + $doc_to_render.CommandName + ').')
            $null = $rtn.Add('')

            return $rtn
        }


    }
    process {

        if ($Name -in $script:noncoresmo -or $Name -in $script:windowsonly) {
            $availability = 'Windows only'
        }
        try {
            $thishelp = Get-Help $Name -Full
        } catch {
            Stop-Function -Message "Issue getting help for $Name" -Target $Name -ErrorRecord $_ -Continue
        }

        $thebase = @{ }
        $thebase.CommandName = $Name
        $thebase.Name = $thishelp.Name

        $thebase.Availability = $availability

        $alias = Get-Alias -Definition $Name -ErrorAction SilentlyContinue
        $thebase.Alias = $alias.Name -Join ','

        ## fetch the description
        $thebase.Description = $thishelp.Description.Text

        ## fetch examples
        $thebase.Examples = Get-DbaTrimmedString -Text ($thishelp.Examples | Out-String -Width 200)

        ## fetch help link
        $thebase.Links = ($thishelp.relatedLinks).NavigationLink.Uri

        ## fetch the synopsis
        $thebase.Synopsis = $thishelp.Synopsis

        ## fetch the syntax
        $thebase.Syntax = Get-DbaTrimmedString -Text ($thishelp.Syntax | Out-String -Width 600)

        ## store notes
        $as = $thishelp.AlertSet | Out-String -Width 600

        ## fetch the tags
        $tags = $tagsrex.Match($as).Groups[1].Value
        if ($tags) {
            $thebase.Tags = $tags.Split(',').Trim()
        }
        ## fetch the author
        $author = $authorRex.Match($as).Groups[1].Value
        if ($author) {
            $thebase.Author = $author.Trim()
        }

        ## fetch MinimumVersion
        $MinimumVersion = $minverRex.Match($as).Groups[1].Value
        if ($MinimumVersion) {
            $thebase.MinimumVersion = $MinimumVersion.Trim()
        }

        ## fetch MaximumVersion
        $MaximumVersion = $maxverRex.Match($as).Groups[1].Value
        if ($MaximumVersion) {
            $thebase.MaximumVersion = $MaximumVersion.Trim()
        }

        ## fetch Parameters
        $parameters = $thishelp.parameters.parameter
        $command = Get-Command $Name
        $params = @()
        foreach ($p in $parameters) {
            $paramAlias = $command.parameters[$p.Name].Aliases
            $validValues = $command.parameters[$p.Name].Attributes.ValidValues -Join ','
            $paramDescr = Get-DbaTrimmedString -Text ($p.Description | Out-String -Width 200)
            $params += , @($p.Name, $paramDescr, ($paramAlias -Join ','), ($p.Required -eq $true), $p.PipelineInput, $p.DefaultValue, $validValues)
        }

        $thebase.Params = $params

        if ($OutputAs -eq "PSObject") {
            [pscustomobject]$thebase
        } elseif ($OutputAs -eq "MDString") {
            Get-DbaDocsMD -doc_to_render $thebase
        }

    }
    end {

    }
}
# SIG # Begin signature block
# MIIZewYJKoZIhvcNAQcCoIIZbDCCGWgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUTIeYKrIuKW7fUjJgNJmBu40I
# 282gghSJMIIE/jCCA+agAwIBAgIQDUJK4L46iP9gQCHOFADw3TANBgkqhkiG9w0B
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
# MRYEFJo2oJRxikvIRBEHv/kyaLtdxSmpMA0GCSqGSIb3DQEBAQUABIIBABwW0Hpr
# XlkXW0ab88NdnD3V/4hJAMqWBaH5qdA8VLISEx8jXzk2bwuR4YSHQtxKSFZYmzlV
# GhbM1N0OGKSFo17DqbVoxfMLclxemRKAvkWxj+R7wXHR3/PTL6cnPGx4MTnKu8PR
# KNDtK51giaWtWNSe36YQ1RfEl1kuf/LYDJn4Ilxe9+douT36h2+dq0aGGK2pyCy4
# 7OsAJFlrKP0uZb29PnDBhOeJKIS1uGnDHejqvnJkIBp8Lf2NQ2Jtg1EYrx9wumvs
# T7Bdn+KwZb+sRzkLQzGJrubKL2/4TahdFQ5LbpEUPA4/mBYcKth+8X0uGTVoTqVB
# F7vEMC6p/WPmmg+hggIwMIICLAYJKoZIhvcNAQkGMYICHTCCAhkCAQEwgYYwcjEL
# MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3
# LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElE
# IFRpbWVzdGFtcGluZyBDQQIQDUJK4L46iP9gQCHOFADw3TANBglghkgBZQMEAgEF
# AKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
# MDgxMTA4MjYxOVowLwYJKoZIhvcNAQkEMSIEICPK35Xkrkv/9Tkgxu9Yroj4WEAp
# O5+N5FrhKN0VPU2gMA0GCSqGSIb3DQEBAQUABIIBAByXR624EBOMCbTNzX+hHTGi
# upV567g0z9car69+CxGCTKYYxfW6OsyQ5Mo/IsJDCGH84lNrOELqKdKiQ+LewuZi
# g9Iqwhme/QUWBPMf31eIuS0vQpWrWso8OUtYbKm5/KD4mjLtoaHf9XSPwgeoNQph
# OuQG66E0qPF5M5ZmjtbvNL7YNtj/wcXiui4Qc/rEeIpMzxuPHkNH/K5T3c6hjypy
# 35BYwIl8jYXtlFjv4W2Jj3q+G5NvxRgEvtzDrT5BD2v26hHPHubSAUBHZQ2mpc7B
# AFYHuifO07C2mX8TG/b2dSZ5xD3cSMAx2hLPk+zBeuN5A6LCH9WueriFkv6CB1A=
# SIG # End signature block
