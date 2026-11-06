<#
.SYNOPSIS  Crée un utilisateur AD de façon idempotente (ne recrée pas s'il existe). Lab.
.NOTES     Mot de passe demandé en SecureString ; supporte -WhatIf/-Confirm.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [Parameter(Mandatory)][string]$Sam,
  [Parameter(Mandatory)][string]$DisplayName,
  [Parameter(Mandatory)][string]$OU,
  [string]$Upn
)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory
if (-not $Upn) { $Upn = "$Sam@corp.meridian.com" }
if (Get-ADUser -Filter "sAMAccountName -eq '$Sam'" -ErrorAction SilentlyContinue) {
  Write-Host "Utilisateur $Sam déjà présent — rien à faire." -ForegroundColor Green
  return
}
if ($PSCmdlet.ShouldProcess($Sam, "Créer l'utilisateur AD")) {
  $pw = Read-Host -AsSecureString "Mot de passe initial pour $Sam"
  New-ADUser -SamAccountName $Sam -Name $DisplayName -DisplayName $DisplayName `
    -UserPrincipalName $Upn -Path $OU -AccountPassword $pw -Enabled $true -ChangePasswordAtLogon $true
  Write-Host "Utilisateur $Sam créé." -ForegroundColor Green
}
