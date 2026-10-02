<#
.SYNOPSIS
This PowerShell script configures the "Allow log on locally"
user right to only allow the Administrators and Users groups.

.NOTES
Author          : Chevelle Gauis Dela Cruz
LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
GitHub          : github.com/chevelledc
Date Created    : 2026-10-02
Last Modified   : 2026-10-02
Version         : 1.0
CVEs            : N/A
Plugin IDs      : N/A
STIG-ID         : WN11-UR-000025
Documentation   : https://www.stigaview.com/products/win11/v2r7/WN11-UR-000025/

.TESTED ON
Date(s) Tested  : 2026-10-02
Tested By       : Chevelle Gauis Dela Cruz
Systems Tested  : Windows 11
PowerShell Ver. : Windows PowerShell 5.1

.USAGE
Run this script from an elevated PowerShell session (Run as Administrator).

```
Example syntax:
PS C:\> .\WN11-UR-000025.ps1
```

#>

# WN11-UR-000025

# Allow log on locally - Administrators and Users only

$Config = "$env:TEMP\WN11-UR-000025.cfg"
$Database = "$env:TEMP\WN11-UR-000025.sdb"

secedit /export /cfg $Config /quiet

$Content = Get-Content $Config

$Content = $Content -replace '^SeInteractiveLogonRight\s*=.*$', 'SeInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-545'

Set-Content -Path $Config -Value $Content

secedit /configure /db $Database /cfg $Config /areas USER_RIGHTS /quiet

gpupdate /force

secedit /export /cfg $Config /quiet

Get-Content $Config | Select-String "SeInteractiveLogonRight"

Remove-Item $Config -Force -ErrorAction SilentlyContinue
Remove-Item $Database -Force -ErrorAction SilentlyContinue
