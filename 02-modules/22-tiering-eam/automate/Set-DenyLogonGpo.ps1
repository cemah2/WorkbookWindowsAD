<#
.SYNOPSIS  Crée 3 GPO de deny logon croisées (Tier0/1/2) et les lie aux OU de machines.
.NOTES     Les User Rights Assignment sont posés via le fichier GptTmpl.inf de chaque GPO.
           ⚠️ Prévoir un accès break-glass avant d'appliquer sur les DC. Lab.
#>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$DomainDN)
$ErrorActionPreference = "Stop"
Import-Module GroupPolicy
# SID bien connus à exclure : on travaille avec les groupes CORP\Tx_Admins
# NOTE : l'édition fine des User Rights via GPO se fait par GptTmpl.inf (SeDenyInteractiveLogonRight, etc.)
# Ici on crée/lie les GPO ; l'injection des droits est détaillée dans build.md (GUI) — à scripter
# en Phase 3 avec le module SecurityPolicyDsc ou l'édition directe du GptTmpl.inf.
$defs = @(
  @{ Name="Tier0-DenyLogon"; Target="OU=Domain Controllers,$DomainDN" },
  @{ Name="Tier1-DenyLogon"; Target="OU=Tier1,OU=Servers,$DomainDN" },
  @{ Name="Tier2-DenyLogon"; Target="OU=Workstations,$DomainDN" }
)
foreach ($d in $defs) {
  if (-not (Get-GPO -Name $d.Name -ErrorAction SilentlyContinue)) { New-GPO -Name $d.Name | Out-Null }
  try { New-GPLink -Name $d.Name -Target $d.Target -LinkEnabled Yes -ErrorAction Stop | Out-Null }
  catch { Write-Warning "Lien existant ou OU absente pour $($d.Name) -> $($d.Target)" }
}
Write-Host "GPO de deny logon créées/liées (injecter les User Rights : voir build.md)." -ForegroundColor Green
