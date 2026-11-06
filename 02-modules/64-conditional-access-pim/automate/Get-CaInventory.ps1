<#
.SYNOPSIS  Inventaire des politiques Conditional Access (état, exclusions). Lecture seule.
#>
[CmdletBinding()] param()
$ErrorActionPreference = "Stop"
Get-MgIdentityConditionalAccessPolicy -All | ForEach-Object {
  [pscustomobject]@{
    Name        = $_.DisplayName
    State       = $_.State
    Users       = ($_.Conditions.Users.IncludeUsers -join ';')
    ExcludeUsers= ($_.Conditions.Users.ExcludeUsers -join ';')
    Apps        = ($_.Conditions.Applications.IncludeApplications -join ';')
    Controls    = ($_.GrantControls.BuiltInControls -join ';')
  }
} | Format-Table -Auto
Write-Host "Vérifie : legacy auth bloquée ? MFA admins ? break-glass en ExcludeUsers ?" -ForegroundColor Yellow
