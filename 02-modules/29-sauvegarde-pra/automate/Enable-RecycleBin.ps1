<#
.SYNOPSIS  Active l'AD Recycle Bin (IRRÉVERSIBLE). Idempotent. Lab.
#>
[CmdletBinding()] param([Parameter(Mandatory)][string]$ForestDN)
$ErrorActionPreference = "Stop"; Import-Module ActiveDirectory
$f = Get-ADOptionalFeature "Recycle Bin Feature"
if ($f.EnabledScopes.Count -eq 0) {
  Enable-ADOptionalFeature "Recycle Bin Feature" -Scope ForestOrConfigurationSet -Target $ForestDN -Confirm:$false
  Write-Host "AD Recycle Bin activée (irréversible)." -ForegroundColor Green
} else { Write-Host "AD Recycle Bin déjà active." -ForegroundColor Green }
