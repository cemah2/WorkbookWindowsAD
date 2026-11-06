<#
.SYNOPSIS  Crée un partage SMB + dossier DFS-N. Idempotent. Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Server,
  [Parameter(Mandatory)][string]$ShareName,
  [Parameter(Mandatory)][string]$LocalPath,
  [Parameter(Mandatory)][string]$Namespace,     # ex: \\corp.meridian.com\shares
  [Parameter(Mandatory)][string]$RwGroup,
  [Parameter(Mandatory)][string]$RoGroup
)
$ErrorActionPreference = "Stop"
if (-not (Test-Path $LocalPath)) { New-Item -Path $LocalPath -ItemType Directory -Force | Out-Null }
if (-not (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue)) {
  New-SmbShare -Name $ShareName -Path $LocalPath -ChangeAccess $RwGroup -ReadAccess $RoGroup | Out-Null
}
$dfsPath = "$Namespace\$ShareName"
if (-not (Get-DfsnFolder -Path $dfsPath -ErrorAction SilentlyContinue)) {
  New-DfsnFolder -Path $dfsPath -TargetPath "\\$Server\$ShareName" | Out-Null
}
Write-Host "Partage + DFS-N prêts : $dfsPath -> \\$Server\$ShareName" -ForegroundColor Green
