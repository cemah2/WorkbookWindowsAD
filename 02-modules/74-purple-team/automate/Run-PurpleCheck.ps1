<#
.SYNOPSIS  Rejoue une liste de techniques Atomic Red Team et rappelle la règle à vérifier. Lab isolé.
.NOTES     Nécessite Invoke-AtomicRedTeam installé. Vérifier ensuite le SIEM manuellement.
#>
[CmdletBinding()]
param([Parameter(Mandatory)][string[]]$Techniques)
$map = @{
  'T1558.003' = 'kerberoasting.yml (4769 RC4)'
  'T1003.001' = 'lsass-access.yml (Sysmon 10)'
  'T1003.006' = 'dcsync.yml (4662 réplication)'
  'T1070.001' = 'security-log-cleared.yml (1102)'
  'T1098'     = 'rbcd-write.yml (5136)'
  'T1649'     = 'adcs-machine-cert.yml (4886)'
}
foreach ($t in $Techniques) {
  Write-Host "=== $t ===" -ForegroundColor Cyan
  try {
    Invoke-AtomicTest $t -ShowDetails | Out-Host
    Invoke-AtomicTest $t
    Write-Host "Vérifier dans le SIEM -> règle: $($map[$t])" -ForegroundColor Yellow
    Invoke-AtomicTest $t -Cleanup
  } catch { Write-Warning "Atomic indisponible ou test absent: $t" }
}
Write-Host "Mets à jour coverage.md (module 72) selon les alertes observées." -ForegroundColor Green
