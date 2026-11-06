<#
.SYNOPSIS  Délègue "Reset Password" sur une OU à un groupe (dsacls). Idempotent. Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$OuDN,
  [Parameter(Mandatory)][string]$Group   # ex: CORP\T2_EMEA_Support
)
$ErrorActionPreference = "Stop"
# Droit étendu "Reset Password" hérité par les objets user de l'OU
& dsacls $OuDN /I:S /G "${Group}:CA;Reset Password;user" | Out-Null
Write-Host "Délégation Reset Password accordée à $Group sur $OuDN." -ForegroundColor Green
Write-Host "Audit : (Get-Acl \"AD:$OuDN\").Access | ? {-not \$_.IsInherited}" -ForegroundColor DarkGray
