<#
.SYNOPSIS  Exporte les ACE non héritées des OU (audit de délégation). Lecture seule.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$SearchBase,
  [string]$OutFile = ".\acl-report.csv"
)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory
$rows = foreach ($ou in Get-ADOrganizationalUnit -Filter * -SearchBase $SearchBase) {
  $acl = Get-Acl "AD:$($ou.DistinguishedName)"
  $acl.Access | Where-Object { -not $_.IsInherited -and $_.AccessControlType -eq 'Allow' } |
    ForEach-Object {
      [pscustomobject]@{
        OU = $ou.DistinguishedName
        Identity = $_.IdentityReference
        Rights = $_.ActiveDirectoryRights
        Object = $_.ObjectType
      }
    }
}
$rows | Export-Csv -NoTypeInformation -Path $OutFile -Encoding UTF8
Write-Host "Rapport ACL écrit dans $OutFile ($($rows.Count) ACE non héritées)." -ForegroundColor Green
