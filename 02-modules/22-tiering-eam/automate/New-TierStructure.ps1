<#
.SYNOPSIS  Crée OU + groupes d'admin par tier (T0/T1/T2). Idempotent. Lab.
#>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$DomainDN)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory
$admin = "OU=Admin,$DomainDN"
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=Admin)" -SearchBase $DomainDN -ErrorAction SilentlyContinue)) {
  New-ADOrganizationalUnit -Name "Admin" -Path $DomainDN -ProtectedFromAccidentalDeletion:$false
}
foreach ($t in "Tier0","Tier1","Tier2") {
  if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$t)" -SearchBase $admin -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $t -Path $admin -ProtectedFromAccidentalDeletion:$false
  }
}
$map = @{ "T0_Admins"="Tier0"; "T1_Admins"="Tier1"; "T2_Admins"="Tier2" }
foreach ($g in $map.Keys) {
  if (-not (Get-ADGroup -LDAPFilter "(cn=$g)")) {
    New-ADGroup -Name $g -GroupScope Global -GroupCategory Security -Path "OU=$($map[$g]),$admin"
  }
}
Write-Host "Structure de tiering créée/vérifiée." -ForegroundColor Green
