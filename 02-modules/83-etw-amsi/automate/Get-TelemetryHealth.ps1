<#
.SYNOPSIS  Vérifie la santé de la télémétrie (sessions ETW clés, PowerShell logging). Lecture seule.
#>
[CmdletBinding()] param()
Write-Host "== Sessions ETW actives (extrait) ==" -ForegroundColor Cyan
$ets = (logman query -ets) 2>$null
$ets | Select-String -Pattern "Sysmon","EventLog","DiagTrack","Defender","Threat" | ForEach-Object { $_.Line }
Write-Host "`n== PowerShell Script Block Logging ==" -ForegroundColor Cyan
$sbl = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name EnableScriptBlockLogging -ErrorAction SilentlyContinue).EnableScriptBlockLogging
Write-Host ("  EnableScriptBlockLogging = {0}" -f ($(if($sbl -eq 1){"activé (ok)"}else{"NON (angle mort)"})))
Write-Host "`n== Derniers events PowerShell/Operational ==" -ForegroundColor Cyan
try { Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 3 | Select Id, TimeCreated | Format-Table -Auto }
catch { Write-Warning "Journal PowerShell vide ou indisponible." }
