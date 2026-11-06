<#
.SYNOPSIS
  Crée une structure de départ : OU géographiques, groupes AGDLP, quelques utilisateurs.
  Idempotent (ignore ce qui existe déjà). Lab uniquement.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)] [string]$DomainDN      # ex: DC=corp,DC=meridian,DC=com
)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory

function Ensure-OU($name, $path) {
  $dn = "OU=$name,$path"
  if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$name)" -SearchBase $path -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $name -Path $path -ProtectedFromAccidentalDeletion:$false
  }
  return $dn
}

# OU
$emp = Ensure-OU "Employees" $DomainDN
foreach ($r in "EMEA","AMER","APAC") { Ensure-OU $r $emp | Out-Null }
$grp   = Ensure-OU "Groups" $DomainDN
$roles = Ensure-OU "Roles" $grp
$res   = Ensure-OU "Resources" $grp

# Groupes AGDLP
if (-not (Get-ADGroup -LDAPFilter "(cn=R_Finance_EMEA)")) {
  New-ADGroup -Name "R_Finance_EMEA" -GroupScope Global -GroupCategory Security -Path $roles
}
if (-not (Get-ADGroup -LDAPFilter "(cn=RES_FS-Finance_RW)")) {
  New-ADGroup -Name "RES_FS-Finance_RW" -GroupScope DomainLocal -GroupCategory Security -Path $res
}
Add-ADGroupMember -Identity "RES_FS-Finance_RW" -Members "R_Finance_EMEA" -ErrorAction SilentlyContinue

# Utilisateur de démonstration
if (-not (Get-ADUser -LDAPFilter "(sAMAccountName=jon.snow)")) {
  $pw = ConvertTo-SecureString "ChangeMe!$(Get-Random -Maximum 99999)" -AsPlainText -Force
  New-ADUser -Name "Jon Snow" -GivenName "Jon" -Surname "Snow" `
    -SamAccountName "jon.snow" -UserPrincipalName "jon.snow@corp.meridian.com" `
    -Path "OU=EMEA,$emp" -AccountPassword $pw -Enabled $true -ChangePasswordAtLogon $true
  Add-ADGroupMember -Identity "R_Finance_EMEA" -Members "jon.snow"
}

Write-Host "Structure de depart creee/verifiee." -ForegroundColor Green
