<#
.SYNOPSIS  Transfère (ou saisit) les 5 rôles FSMO vers un DC cible.
.NOTES     -Seize = saisie forcée : UNIQUEMENT si l'ancien détenteur est DÉFINITIVEMENT mort,
           et ne jamais le rallumer ensuite (faire un metadata cleanup). Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$TargetDC,
  [switch]$Seize
)
$ErrorActionPreference = "Stop"; Import-Module ActiveDirectory
$roles = 0..4   # 0=PDCEmulator,1=RIDMaster,2=InfrastructureMaster,3=SchemaMaster,4=DomainNamingMaster
$names = "PDCEmulator","RIDMaster","InfrastructureMaster","SchemaMaster","DomainNamingMaster"
if ($Seize) {
  Write-Warning "SAISIE FORCÉE demandée. Assure-toi que l'ancien détenteur est DÉFINITIVEMENT hors service."
  Move-ADDirectoryServerOperationMasterRole -Identity $TargetDC -OperationMasterRole $names -Force
} else {
  Move-ADDirectoryServerOperationMasterRole -Identity $TargetDC -OperationMasterRole $names
}
Write-Host "Rôles FSMO déplacés vers $TargetDC." -ForegroundColor Green
netdom query fsmo
