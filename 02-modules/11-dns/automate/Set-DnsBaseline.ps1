<#
.SYNOPSIS
  Baseline DNS pour un DC : zone inverse, forwarder, mises à jour sécurisées, scavenging.
  Idempotent. Lab uniquement.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)] [string]$Zone,
  [Parameter(Mandatory)] [string]$ReverseNetworkId,   # ex: 10.10.0.0/16
  [Parameter(Mandatory)] [string]$Forwarder
)
$ErrorActionPreference = "Stop"
Import-Module DnsServer

# Mises à jour sécurisées sur la zone directe
Set-DnsServerPrimaryZone -Name $Zone -DynamicUpdate "Secure"

# Zone inverse (si absente)
$revName = ($ReverseNetworkId -split '/')[0]
if (-not (Get-DnsServerZone | Where-Object { $_.ZoneName -like "*in-addr.arpa" -and $_.ZoneName })) {
  Add-DnsServerPrimaryZone -NetworkId $ReverseNetworkId -ReplicationScope "Domain" -DynamicUpdate Secure
}

# Forwarder
Set-DnsServerForwarder -IPAddress $Forwarder -UseRootHint $true

# Scavenging
Set-DnsServerScavenging -ScavengingState $true -RefreshInterval 7.00:00:00 `
  -NoRefreshInterval 7.00:00:00 -ApplyOnAllZones

Write-Host "Baseline DNS appliquee pour $Zone." -ForegroundColor Green
