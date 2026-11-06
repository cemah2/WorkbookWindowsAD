<#
.SYNOPSIS  Installe l'Issuing CA (Enterprise Subordinate) + audit AD CS. Lab.
.NOTES     Génère un CSR à faire signer par la Root hors-ligne (étape manuelle, voir build.md).
#>
[CmdletBinding()]
param([string]$CommonName = "Meridian Issuing CA")
$ErrorActionPreference = "Stop"
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools | Out-Null
try {
  Install-AdcsCertificationAuthority -CAType EnterpriseSubordinateCA `
    -CACommonName $CommonName -KeyLength 4096 -HashAlgorithmName SHA256 -Force
} catch {
  Write-Warning "La config CA peut nécessiter le certificat signé par la Root (voir build.md). $_"
}
# Audit AD CS complet (émission, changements, etc.)
& certutil -setreg CA\AuditFilter 127 | Out-Null
try { Restart-Service certsvc -ErrorAction SilentlyContinue } catch {}
Write-Host "Issuing CA installée (CSR à faire signer par la Root si besoin), audit activé." -ForegroundColor Green
