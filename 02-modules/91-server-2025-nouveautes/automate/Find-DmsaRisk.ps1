<#
.SYNOPSIS  Audit défensif BadSuccessor : OU où l'on peut créer des dMSA + dMSA existants. Lecture seule.
.NOTES     Nécessite un domaine 2025 (dMSA). Signale les ACL CreateChild sur la classe dMSA pour des
           principaux non privilégiés (indice de risque BadSuccessor).
#>
[CmdletBinding()] param([Parameter(Mandatory)][string]$BaseDN)
$ErrorActionPreference = "Stop"; Import-Module ActiveDirectory
Write-Host "== dMSA existants + liens de succession ==" -ForegroundColor Cyan
try {
  Get-ADServiceAccount -Filter * -Properties msDS-DelegatedMSAState,msDS-ManagedAccountPrecededByLink -ErrorAction Stop |
    Select Name, 'msDS-DelegatedMSAState', 'msDS-ManagedAccountPrecededByLink' | Format-Table -Auto
} catch { Write-Warning "Pas de dMSA ou domaine non-2025." }

Write-Host "== OU avec droit de création d'objets (indice CreateChild) ==" -ForegroundColor Cyan
foreach ($ou in Get-ADOrganizationalUnit -Filter * -SearchBase $BaseDN) {
  $acl = Get-Acl "AD:$($ou.DistinguishedName)"
  $acl.Access | Where-Object {
    -not $_.IsInherited -and $_.AccessControlType -eq 'Allow' -and
    $_.ActiveDirectoryRights -match 'CreateChild|GenericAll|WriteDacl'
  } | ForEach-Object {
    [pscustomobject]@{ OU=$ou.DistinguishedName; Identity=$_.IdentityReference; Rights=$_.ActiveDirectoryRights }
  }
} | Format-Table -Auto
Write-Host "Vérifie : aucun principal non-Tier0 ne doit pouvoir créer de dMSA (risque BadSuccessor)." -ForegroundColor Yellow
