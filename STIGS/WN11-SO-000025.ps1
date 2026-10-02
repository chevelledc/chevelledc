<#
.SYNOPSIS
This PowerShell script renames the built-in Windows Guest account
to prevent it from retaining the default account name.

.NOTES
Author          : Chevelle Gauis Dela Cruz
LinkedIn        : linkedin.com/in/chevellegauisdelacruz/
GitHub          : github.com/chevelledc
Date Created    : 2026-10-02
Last Modified   : 2026-10-02
Version         : 1.0
CVEs            : N/A
Plugin IDs      : N/A
STIG-ID         : WN11-SO-000025
Documentation   : https://www.stigaview.com/products/win11/v2r7/WN11-SO-000025/

.TESTED ON
Date(s) Tested  : 2026-10-02
Tested By       : Chevelle Gauis Dela Cruz
Systems Tested  : Windows 11
PowerShell Ver. : Windows PowerShell 5.1

.USAGE
Run this script from an elevated PowerShell session (Run as Administrator).

```
Example syntax:
PS C:\> .\WN11-SO-000025.ps1
```

#>

# WN11-SO-000025

# Rename the built-in Guest account

$GuestAccount = Get-LocalUser | Where-Object { $_.SID.Value -match '-501$' }

if ($GuestAccount) {
Rename-LocalUser -Name $GuestAccount.Name -NewName "GuestDisabled"
}

Get-LocalUser | Where-Object { $_.SID.Value -match '-501$' } | Select-Object Name, Enabled, SID
