<#
.SYNOPSIS  Inventaire des appareils Entra (jonction/compliance). Lecture seule.
#>
[CmdletBinding()] param([string]$OutFile = ".\devices.csv")
$ErrorActionPreference = "Stop"
Get-MgDevice -All | Select DisplayName, TrustType, IsCompliant, IsManaged, OperatingSystem, ApproximateLastSignInDateTime |
  Export-Csv -NoTypeInformation -Path $OutFile -Encoding UTF8
Write-Host "Appareils exportés dans $OutFile (TrustType: ServerAd=HAADJ, AzureAd=AADJ, Workplace=registered)" -ForegroundColor Green
