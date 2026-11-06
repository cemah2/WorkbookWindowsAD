<#
.SYNOPSIS  État de la synchronisation Entra Connect (lecture seule). À exécuter sur le serveur Connect.
#>
[CmdletBinding()] param()
Import-Module ADSync -ErrorAction Stop
Get-ADSyncScheduler | Select SyncCycleEnabled, SchedulerSuspended, NextSyncCyclePolicyType, NextSyncCycleStartTimeInUTC
Write-Host "`n== Derniers runs ==" -ForegroundColor Cyan
Get-ADSyncConnectorRunStatus
