<#
.SYNOPSIS  État de santé Kerberos défensif (lecture seule). Lab/entreprise.
#>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$BaseDN)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory

Write-Host "== Comptes avec SPN (cibles Kerberoasting) ==" -ForegroundColor Cyan
Get-ADUser -LDAPFilter "(servicePrincipalName=*)" -SearchBase $BaseDN -Properties servicePrincipalName,msDS-SupportedEncryptionTypes |
  Select SamAccountName, @{n='SPNs';e={$_.servicePrincipalName -join ';'}}, 'msDS-SupportedEncryptionTypes' | Format-Table -Auto

Write-Host "== Comptes sans pré-auth (AS-REP roastable) ==" -ForegroundColor Cyan
Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=4194304)" -SearchBase $BaseDN |
  Select SamAccountName | Format-Table -Auto

Write-Host "== Derniers événements Kerberos (4768/4769/4771) ==" -ForegroundColor Cyan
try {
  Get-WinEvent -FilterHashtable @{LogName='Security';Id=4768,4769,4771} -MaxEvents 15 -ErrorAction Stop |
    Select TimeCreated, Id | Format-Table -Auto
} catch { Write-Warning "Audit Kerberos non activé ou journal vide (voir build.md Étape 3)." }
