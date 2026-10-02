<#
.SYNOPSIS
This PowerShell script enables the Windows password complexity
requirement for local account passwords.

.NOTES
Author          : Chevelle Gauis Dela Cruz
LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
GitHub          : github.com/chevelledc
Date Created    : 2026-10-02
Last Modified   : 2026-10-02
Version         : 1.0
CVEs            : N/A
Plugin IDs      : N/A
STIG-ID         : WN11-AC-000040

.TESTED ON
Date(s) Tested  : 2026-10-02
Tested By       : Chevelle Gauis Dela Cruz
Systems Tested  : Windows 11
PowerShell Ver. : Windows PowerShell 5.1

.USAGE
Run this script from an elevated PowerShell session (Run as Administrator).

```
Example syntax:
PS C:\> .\WN11-AC-000040.ps1
```

#>

# WN11-AC-000040

# Enable password complexity requirements

secedit /export /cfg "$env:TEMP\WN11-AC-000040.cfg" /quiet

$Config = Get-Content "$env:TEMP\WN11-AC-000040.cfg"

$Config = $Config -replace '^PasswordComplexity\s*=.*$', 'PasswordComplexity = 1'

Set-Content "$env:TEMP\WN11-AC-000040.cfg" $Config

secedit /configure /db "$env:TEMP\WN11-AC-000040.sdb" /cfg "$env:TEMP\WN11-AC-000040.cfg" /areas SECURITYPOLICY /quiet

gpupdate /force

secedit /export /cfg "$env:TEMP\WN11-AC-000040-verify.cfg" /quiet

Get-Content "$env:TEMP\WN11-AC-000040-verify.cfg" | Select-String "PasswordComplexity"

Remove-Item "$env:TEMP\WN11-AC-000040.cfg" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\WN11-AC-000040.sdb" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\WN11-AC-000040-verify.cfg" -Force -ErrorAction SilentlyContinue
