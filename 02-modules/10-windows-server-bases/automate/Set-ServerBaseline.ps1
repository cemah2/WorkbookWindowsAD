<#
.SYNOPSIS
  Préparation de base d'un Windows Server (nom, IP statique, DNS, fuseau, remoting).
  Idempotent : réexécutable sans effet de bord majeur. Lab uniquement.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)] [string]$NewName,
  [Parameter(Mandatory)] [string]$IPAddress,
  [int]$PrefixLength = 16,
  [Parameter(Mandatory)] [string]$Gateway,
  [Parameter(Mandatory)] [string]$Dns,
  [string]$TimeZone = "Romance Standard Time",
  [string]$InterfaceAlias = "Ethernet"
)

$ErrorActionPreference = "Stop"

# 1. Fuseau horaire + resync
Set-TimeZone -Id $TimeZone
w32tm /resync | Out-Null

# 2. IP statique (supprime l'ancienne config IPv4 de l'interface puis réapplique)
$if = Get-NetAdapter -Name $InterfaceAlias
Get-NetIPAddress -InterfaceAlias $InterfaceAlias -AddressFamily IPv4 -ErrorAction SilentlyContinue |
  Remove-NetIPAddress -Confirm:$false -ErrorAction SilentlyContinue
Remove-NetRoute -InterfaceAlias $InterfaceAlias -DestinationPrefix "0.0.0.0/0" -Confirm:$false -ErrorAction SilentlyContinue
New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress `
  -PrefixLength $PrefixLength -DefaultGateway $Gateway | Out-Null
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $Dns

# 3. Remoting
Enable-PSRemoting -Force | Out-Null

# 4. Renommage (déclenche un redémarrage si nécessaire)
if ($env:COMPUTERNAME -ne $NewName) {
  Rename-Computer -NewName $NewName -Force
  Write-Host "Renommé en $NewName — redémarrage..." -ForegroundColor Yellow
  Restart-Computer -Force
} else {
  Write-Host "Nom déjà correct ($NewName). Base prête." -ForegroundColor Green
}
