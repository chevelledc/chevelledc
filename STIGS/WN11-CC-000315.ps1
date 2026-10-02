<#
.SYNOPSIS
    This PowerShell script disables the Windows Installer policy
    "Always install with elevated privileges."

.NOTES
    Author          : Chevelle Gauis Dela Cruz
    LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
    GitHub          : github.com/joshmadakor1
    Date Created    : 2026-10-02
    Last Modified   : 2026-10-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 2026-10-02
    Tested By       : Chevelle Gauis Dela Cruz
    Systems Tested  : Windows 11
    PowerShell Ver. : Windows PowerShell 5.1

.USAGE
    Run this script from an elevated PowerShell session (Run as Administrator).

    Example syntax:
    PS C:\> .\WN11-CC-000315.ps1
#>

# WN11-CC-000315
# Disable "Always install with elevated privileges"

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"

New-Item -Path $Path -Force | Out-Null

New-ItemProperty `
    -Path $Path `
    -Name "AlwaysInstallElevated" `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null

gpupdate /force

Get-ItemProperty `
    -Path $Path `
    -Name "AlwaysInstallElevated"
