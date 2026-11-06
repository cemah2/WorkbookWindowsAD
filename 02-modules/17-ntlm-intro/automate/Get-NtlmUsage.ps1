<#
.SYNOPSIS  Inventaire de l'usage NTLM (journal NTLM/Operational). Lecture seule.
.NOTES     Nécessite l'audit NTLM activé (voir build.md). Lab/entreprise.
#>
[CmdletBinding()]
param([int]$MaxEvents = 200, [string]$OutFile = ".\ntlm-usage.csv")
$ErrorActionPreference = "Stop"
try {
  $ev = Get-WinEvent -LogName "Microsoft-Windows-NTLM/Operational" -MaxEvents $MaxEvents -ErrorAction Stop
  $ev | Select TimeCreated, Id, Message | Export-Csv -NoTypeInformation -Path $OutFile -Encoding UTF8
  Write-Host "Usage NTLM exporté dans $OutFile ($($ev.Count) événements)." -ForegroundColor Green
} catch {
  Write-Warning "Journal NTLM/Operational vide ou audit NTLM non activé (voir build.md Étape 2)."
}
