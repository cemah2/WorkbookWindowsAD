<#
.SYNOPSIS  Audit défensif des templates de certificats (signale les indices ESC1). Lecture seule.
.NOTES     Nécessite le module PSPKI (Install-Module PSPKI). Lab/entreprise.
#>
[CmdletBinding()] param()
$ErrorActionPreference = "Stop"
try { Import-Module PSPKI -ErrorAction Stop } catch { throw "Module PSPKI requis : Install-Module PSPKI" }
$authEkus = @("Client Authentication","Smart Card Logon","PKINIT Client Authentication","Any Purpose")
Get-CertificateTemplate | ForEach-Object {
  $ess = $_.EnrolleeSuppliesSubject
  $eku = @($_.ExtendedKeyUsage | ForEach-Object { $_.FriendlyName })
  $authCapable = ($eku | Where-Object { $authEkus -contains $_ }) -or ($eku.Count -eq 0)
  [pscustomobject]@{
    Template      = $_.Name
    EnrolleeSAN   = $ess
    AuthCapable   = [bool]$authCapable
    PotentialESC1 = ([bool]$ess -and [bool]$authCapable)
    EKU           = ($eku -join ';')
  }
} | Sort-Object PotentialESC1 -Descending | Format-Table -Auto
Write-Host "Vérifie les lignes PotentialESC1=True : SAN libre + EKU d'auth = risque ESC1." -ForegroundColor Yellow
