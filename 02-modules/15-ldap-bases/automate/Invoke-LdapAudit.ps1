<#
.SYNOPSIS  Audit LDAP défensif : expose les objets à risque (SPN, no-preauth, groupes sensibles).
           Lecture seule. Lab/entreprise.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$BaseDN,
  [string]$OutFile = ".\ldap-audit.csv"
)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory
$rows = @()
$rows += Get-ADUser -LDAPFilter "(servicePrincipalName=*)" -SearchBase $BaseDN -Properties servicePrincipalName |
  ForEach-Object { [pscustomobject]@{ Type="SPN"; Name=$_.SamAccountName; Detail=($_.servicePrincipalName -join ';') } }
$rows += Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=4194304)" -SearchBase $BaseDN |
  ForEach-Object { [pscustomobject]@{ Type="NoPreAuth"; Name=$_.SamAccountName; Detail="AS-REP roastable" } }
foreach ($g in "Domain Admins","Enterprise Admins","Account Operators","DnsAdmins") {
  try { Get-ADGroupMember $g -Recursive | ForEach-Object {
    $rows += [pscustomobject]@{ Type="SensitiveGroup"; Name=$_.SamAccountName; Detail=$g } } } catch {}
}
$rows | Export-Csv -NoTypeInformation -Path $OutFile -Encoding UTF8
Write-Host "Audit LDAP écrit dans $OutFile ($($rows.Count) lignes)." -ForegroundColor Green
