<#
.SYNOPSIS  Audit défensif rapide AD CS : réglages CA à risque + rappels d'outils. Lecture seule.
.NOTES     Pour l'audit complet : certipy find -vulnerable (Linux) ou Invoke-Locksmith. Lab/entreprise.
#>
[CmdletBinding()] param()
Write-Host "== Réglages CA à risque ==" -ForegroundColor Cyan
try {
  $flags = & certutil -getreg policy\EditFlags 2>$null
  if ($flags -match "EDITF_ATTRIBUTESUBJECTALTNAME2") {
    Write-Warning "EDITF_ATTRIBUTESUBJECTALTNAME2 ACTIF sur la CA -> ESC6 ! Retirer ce flag."
  } else { Write-Host "EDITF_ATTRIBUTESUBJECTALTNAME2 non détecté (bien)." -ForegroundColor Green }
} catch { Write-Warning "certutil indisponible ou pas sur la CA." }

Write-Host "`n== Rappels d'audit (à lancer) ==" -ForegroundColor Cyan
@"
  Offensif/audit (Linux)  : certipy find -u user@dom -p '***' -dc-ip <dc> -vulnerable -stdout
  Défensif (Windows)      : Install-Module Locksmith ; Invoke-Locksmith -Mode 1
  Templates (PSPKI)       : voir module 42 Audit-CertTemplates.ps1
  Mapping fort (KB5014754): vérifier StrongCertificateBindingEnforcement = 2 (Full) sur les DC
"@ | Write-Host
