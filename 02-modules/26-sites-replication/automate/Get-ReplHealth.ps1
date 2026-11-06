<#
.SYNOPSIS  Résumé de santé de réplication AD (lecture seule).
#>
[CmdletBinding()] param()
& repadmin /replsummary
Write-Host "`n== Metadata partenaires ==" -ForegroundColor Cyan
Get-ADReplicationPartnerMetadata -Target * -ErrorAction SilentlyContinue |
  Select Server, Partner, LastReplicationSuccess, LastReplicationResult | Format-Table -Auto
