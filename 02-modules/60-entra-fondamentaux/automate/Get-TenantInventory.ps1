<#
.SYNOPSIS  Inventaire d'un tenant Entra (users, rôles, apps, service principals). Lecture seule.
#>
[CmdletBinding()] param([string]$OutFile = ".\tenant-inventory.json")
$ErrorActionPreference = "Stop"
$inv = [ordered]@{
  org   = Get-MgOrganization | Select DisplayName, Id
  users = Get-MgUser -All | Select DisplayName, UserPrincipalName, AccountEnabled
  roles = Get-MgDirectoryRole -All | Select DisplayName, Id
  apps  = Get-MgApplication -All | Select DisplayName, AppId
  sps   = Get-MgServicePrincipal -All | Select DisplayName, AppId, ServicePrincipalType
}
$inv | ConvertTo-Json -Depth 5 | Out-File $OutFile -Encoding UTF8
Write-Host "Inventaire écrit dans $OutFile" -ForegroundColor Green
