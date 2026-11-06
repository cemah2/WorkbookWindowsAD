<#
.SYNOPSIS  Crée la topologie de sites CORP (sites, subnets, site links). Idempotent. Lab.
#>
[CmdletBinding()] param()
$ErrorActionPreference = "Stop"; Import-Module ActiveDirectory
$sites   = @("EMEA","AMER","APAC")
$subnets = @{ "10.10.0.0/16"="EMEA"; "10.20.0.0/16"="AMER"; "10.30.0.0/16"="APAC" }
$links   = @(
  @{ Name="EMEA-AMER"; Sites=@("EMEA","AMER"); Cost=100; Freq=15 },
  @{ Name="EMEA-APAC"; Sites=@("EMEA","APAC"); Cost=300; Freq=60 }
)
foreach ($s in $sites) { if (-not (Get-ADReplicationSite -Filter "Name -eq '$s'")) { New-ADReplicationSite -Name $s } }
foreach ($n in $subnets.Keys) {
  if (-not (Get-ADReplicationSubnet -Filter "Name -eq '$n'" -ErrorAction SilentlyContinue)) {
    New-ADReplicationSubnet -Name $n -Site $subnets[$n]
  }
}
foreach ($l in $links) {
  if (-not (Get-ADReplicationSiteLink -Filter "Name -eq '$($l.Name)'" -ErrorAction SilentlyContinue)) {
    New-ADReplicationSiteLink -Name $l.Name -SitesIncluded $l.Sites -Cost $l.Cost -ReplicationFrequencyInMinutes $l.Freq
  }
}
Write-Host "Topologie de sites appliquée." -ForegroundColor Green
