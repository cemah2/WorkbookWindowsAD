<#
.SYNOPSIS  Affiche les 5 détenteurs FSMO (lecture seule).
#>
Import-Module ActiveDirectory
$f = Get-ADForest; $d = Get-ADDomain
[pscustomobject]@{
  SchemaMaster         = $f.SchemaMaster
  DomainNamingMaster   = $f.DomainNamingMaster
  PDCEmulator          = $d.PDCEmulator
  RIDMaster            = $d.RIDMaster
  InfrastructureMaster = $d.InfrastructureMaster
} | Format-List
