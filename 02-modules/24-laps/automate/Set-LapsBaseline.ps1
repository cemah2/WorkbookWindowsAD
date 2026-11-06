<#
.SYNOPSIS  Prépare Windows LAPS sur une OU (schéma + self-write + read). Idempotent. Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$ComputersOU,
  [Parameter(Mandatory)][string]$ReadGroup
)
$ErrorActionPreference = "Stop"
Import-Module LAPS
# Schéma (ignore si déjà étendu)
try { Update-LapsADSchema -ErrorAction Stop | Out-Null } catch { Write-Host "Schéma LAPS déjà présent." }
Set-LapsADComputerSelfPermission -Identity $ComputersOU | Out-Null
Set-LapsADReadPasswordPermission -Identity $ComputersOU -AllowedPrincipals $ReadGroup | Out-Null
Write-Host "LAPS préparé sur $ComputersOU (lecture: $ReadGroup). Politique à poser par GPO." -ForegroundColor Green
