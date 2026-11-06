<#
.SYNOPSIS
  Installe AD DS et promeut le serveur en premier DC d'une nouvelle forêt. Lab uniquement.
.NOTES
  Le mot de passe DSRM est saisi en SecureString (jamais stocké en clair).
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)] [string]$DomainName,       # ex: corp.meridian.com
  [Parameter(Mandatory)] [string]$NetbiosName,      # ex: CORP
  [string]$ForestMode = "WinThreshold",             # 2016
  [string]$DomainMode = "WinThreshold",
  [switch]$SelfDns                                   # repointe le DNS client sur 127.0.0.1
)

$ErrorActionPreference = "Stop"

# 1. Rôle AD DS (+ outils)
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools | Out-Null

# 2. Mot de passe DSRM (sécurisé)
$dsrm = Read-Host -AsSecureString "Mot de passe DSRM (Directory Services Restore Mode)"

Import-Module ADDSDeployment

# 3. Promotion en nouvelle forêt
Install-ADDSForest `
  -DomainName $DomainName `
  -DomainNetbiosName $NetbiosName `
  -ForestMode $ForestMode `
  -DomainMode $DomainMode `
  -InstallDns `
  -SafeModeAdministratorPassword $dsrm `
  -NoRebootOnCompletion `
  -Force

# 4. (optionnel) DNS client sur lui-même — effectif après redémarrage
if ($SelfDns) {
  $alias = (Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1).Name
  Set-DnsClientServerAddress -InterfaceAlias $alias -ServerAddresses 127.0.0.1
}

Write-Host "Promotion configurée. Redémarre le serveur pour finaliser." -ForegroundColor Green
