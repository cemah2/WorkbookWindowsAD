<#
.SYNOPSIS  Configure la PRP d'un RODC (allow d'un groupe agence) et audite les comptes révélés.
.NOTES     Les comptes sensibles restent dans "Denied RODC Password Replication Group". Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Rodc,
  [Parameter(Mandatory)][string]$AllowedGroup
)
$ErrorActionPreference = "Stop"; Import-Module ActiveDirectory
Add-ADGroupMember -Identity "Allowed RODC Password Replication Group" -Members $AllowedGroup -ErrorAction SilentlyContinue
Write-Host "== Comptes actuellement révélés sur $Rodc ==" -ForegroundColor Cyan
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity $Rodc -RevealedAccounts |
  Select SamAccountName | Format-Table -Auto
Write-Host "Rappel : aucun compte Tier 0 ne doit apparaître ci-dessus." -ForegroundColor Yellow
