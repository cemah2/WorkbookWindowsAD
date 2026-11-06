<#
.SYNOPSIS  Sauvegarde System State d'un DC + liste des versions. Lab.
#>
[CmdletBinding()] param([Parameter(Mandatory)][string]$Target)
$ErrorActionPreference = "Stop"
if (-not (Get-WindowsFeature Windows-Server-Backup).Installed) {
  Install-WindowsFeature Windows-Server-Backup | Out-Null
}
& wbadmin start systemstatebackup -backupTarget:$Target -quiet
Write-Host "== Versions de sauvegarde ==" -ForegroundColor Cyan
& wbadmin get versions
