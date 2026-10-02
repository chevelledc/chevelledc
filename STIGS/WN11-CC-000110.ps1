<#
.SYNOPSIS
    This PowerShell script disables printing over HTTP by configuring
    the Windows policy "Turn off printing over HTTP" to Enabled.

.NOTES
    Author          : Chevelle Gauis Dela Cruz
    LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
    GitHub          : github.com/chevelledc
    Date Created    : 2026-10-02
    Last Modified   : 2026-10-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 2026-10-02
    Tested By       : Chevelle Gauis Dela Cruz
    Systems Tested  : Windows 11
    PowerShell Ver. : Windows PowerShell 5.1

.USAGE
    Run this script from an elevated PowerShell session (Run as Administrator).

    Example syntax:
    PS C:\> .\WN11-CC-000110.ps1
#>

# WN11-CC-000110
# Disable printing over HTTP

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"

New-ItemProperty `
    -Path $Path `
    -Name "DisableHTTPPrinting" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

gpupdate /force

Get-ItemProperty `
    -Path $Path `
    -Name "DisableHTTPPrinting"
