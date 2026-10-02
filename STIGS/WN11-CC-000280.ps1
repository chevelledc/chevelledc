<#
.SYNOPSIS
    This PowerShell script configures Windows 11 to always prompt
    for a password when connecting to Remote Desktop Services.

.NOTES
    Author          : Chevelle Gauis Dela Cruz
    LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
    GitHub          : github.com/chevelledc
    Date Created    : 2026-10-02
    Last Modified   : 2026-10-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000280
    Documentation   : https://www.stigaview.com/products/win11/v2r7/WN11-CC-000280/

.TESTED ON
    Date(s) Tested  : 2026-10-02
    Tested By       : Chevelle Gauis Dela Cruz
    Systems Tested  : Windows 11
    PowerShell Ver. : Windows PowerShell 5.1

.USAGE
    Run this script from an elevated PowerShell session (Run as Administrator).

    Example syntax:
    PS C:\> .\WN11-CC-000280.ps1
#>

# WN11-CC-000280
# Always prompt for password upon connection

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

New-ItemProperty `
    -Path $Path `
    -Name "fPromptForPassword" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

gpupdate /force

Get-ItemProperty `
    -Path $Path `
    -Name "fPromptForPassword"
