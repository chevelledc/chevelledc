<#
.SYNOPSIS
Sets the minimum password length to 14 characters.

.NOTES
Author          : Chevelle Gauis Dela Cruz
LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
GitHub          : github.com/chevelledc
Date Created    : 2026-10-02
Last Modified   : 2026-10-02
Version         : 1.0
CVEs            : N/A
Plugin IDs      : N/A
STIG-ID         : WN11-AC-000035
Documentation   : https://www.stigaview.com/products/win11/v2r7/WN11-AC-000035/

.TESTED ON
Date(s) Tested  : 2026-10-02
Tested By       : Chevelle Gauis Dela Cruz
Systems Tested  : Windows 11
PowerShell Ver. : Windows PowerShell 5.1

.USAGE
Run this script from an elevated PowerShell session (Run as Administrator).

```
Example syntax:
PS C:\> .\WN11-AC-000035.ps1
```

#>

# WN11-AC-000035

# Set minimum password length to 14 characters

secedit /export /cfg "$env:TEMP\WN11-AC-000035.cfg" /quiet

$Config = Get-Content "$env:TEMP\WN11-AC-000035.cfg"

$Config = $Config -replace '^MinimumPasswordLength\s*=.*$', 'MinimumPasswordLength = 14'

Set-Content "$env:TEMP\WN11-AC-000035.cfg" $Config

secedit /configure /db "$env:TEMP\WN11-AC-000035.sdb" /cfg "$env:TEMP\WN11-AC-000035.cfg" /areas SECURITYPOLICY /quiet

gpupdate /force

secedit /export /cfg "$env:TEMP\WN11-AC-000035-verify.cfg" /quiet

Get-Content "$env:TEMP\WN11-AC-000035-verify.cfg" | Select-String "MinimumPasswordLength"

Remove-Item "$env:TEMP\WN11-AC-000035.cfg" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\WN11-AC-000035.sdb" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\WN11-AC-000035-verify.cfg" -Force -ErrorAction SilentlyContinue
