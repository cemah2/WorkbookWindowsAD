<#
.SYNOPSIS  Installe ou met à jour Sysmon avec une configuration. Idempotent. Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$SysmonExe,
  [Parameter(Mandatory)][string]$ConfigXml
)
$ErrorActionPreference = "Stop"
if (Get-Service -Name "Sysmon*" -ErrorAction SilentlyContinue) {
  & $SysmonExe -c $ConfigXml      # déjà installé -> mise à jour de la config
  Write-Host "Config Sysmon mise à jour." -ForegroundColor Green
} else {
  & $SysmonExe -accepteula -i $ConfigXml
  Write-Host "Sysmon installé." -ForegroundColor Green
}
Get-Service -Name "Sysmon*" | Select Name, Status
