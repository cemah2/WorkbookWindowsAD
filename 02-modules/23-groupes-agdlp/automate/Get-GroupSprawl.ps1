<#
.SYNOPSIS  Audit d'hygiène des groupes : groupes vides et imbrications profondes. Lecture seule.
#>
[CmdletBinding()] param([int]$DepthAlert = 3)
$ErrorActionPreference = "Stop"; Import-Module ActiveDirectory
Write-Host "== Groupes vides ==" -ForegroundColor Cyan
Get-ADGroup -Filter * -Properties Members | Where-Object { $_.Members.Count -eq 0 } | Select Name
Write-Host "== Groupes imbriqués dans des groupes à privilèges ==" -ForegroundColor Cyan
foreach ($g in "Domain Admins","Enterprise Admins","Administrators") {
  Get-ADGroupMember $g -Recursive -ErrorAction SilentlyContinue |
    Where-Object objectClass -eq 'group' | Select @{n='PrivGroup';e={$g}}, Name
}
