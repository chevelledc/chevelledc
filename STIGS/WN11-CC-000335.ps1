<#
.SYNOPSIS
Disables unencrypted traffic for the Windows Remote Management (WinRM) client.

.NOTES
Author          : Chevelle Gauis Dela Cruz
LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
GitHub          : github.com/chevelledc
Date Created    : 2026-10-02
Last Modified   : 2026-10-02
Version         : 1.0
CVEs            : N/A
Plugin IDs      : N/A
STIG-ID         : WN11-CC-000335

.TESTED ON
Date(s) Tested  : 2026-10-02
Tested By       : Chevelle Gauis Dela Cruz
Systems Tested  : Windows 11
PowerShell Ver. : Windows PowerShell 5.1

.USAGE
Run this script from an elevated PowerShell session (Run as Administrator).

```
Example syntax:
PS C:\> .\WN11-CC-000335.ps1
```

#>

# WN11-CC-000335

# Disable unencrypted WinRM client traffic

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"

if (-not (Test-Path $Path)) {
New-Item -Path $Path -Force | Out-Null
}

New-ItemProperty -Path $Path -Name "AllowUnencryptedTraffic" -PropertyType DWord -Value 0 -Force | Out-Null

gpupdate /force

Get-ItemProperty -Path $Path -Name "AllowUnencryptedTraffic"
