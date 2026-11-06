<#
.SYNOPSIS  Audit des privilèges sensibles du token courant (et rappel des droits à surveiller). Lecture seule.
.NOTES     Pour un audit à l'échelle : inspecter les User Rights Assignment via GPO/secpol.
#>
[CmdletBinding()] param()
$sensitive = "SeDebugPrivilege","SeImpersonatePrivilege","SeAssignPrimaryTokenPrivilege",
             "SeBackupPrivilege","SeRestorePrivilege","SeTakeOwnershipPrivilege","SeLoadDriverPrivilege",
             "SeTcbPrivilege"
Write-Host "== Privilèges du token courant ==" -ForegroundColor Cyan
$priv = (whoami /priv) 2>$null
$priv
Write-Host "`n== Privilèges sensibles présents ==" -ForegroundColor Yellow
foreach ($p in $sensitive) { if ($priv -match $p) { Write-Host "  [!] $p" -ForegroundColor Red } }
Write-Host "`nAstuce : auditer les User Rights Assignment (GPO) pour voir QUI reçoit ces privilèges."
