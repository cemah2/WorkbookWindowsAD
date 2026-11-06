<#
.SYNOPSIS  Crée/lie une GPO de base (bannière légale). Idempotent. Lab.
#>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$DomainDN)
$ErrorActionPreference = "Stop"
Import-Module GroupPolicy
$name = "CORP-Baseline-Legal"
$gpo = Get-GPO -Name $name -ErrorAction SilentlyContinue
if (-not $gpo) { $gpo = New-GPO -Name $name -Comment "Baseline bannière légale" }
$key = "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System"
Set-GPRegistryValue -Name $name -Key $key -ValueName legalnoticecaption -Type String -Value "Acces reserve" | Out-Null
Set-GPRegistryValue -Name $name -Key $key -ValueName legalnoticetext -Type String -Value "Systeme CORP - acces autorise uniquement." | Out-Null
if (-not (Get-GPInheritance -Target $DomainDN).GpoLinks.DisplayName -contains $name) {
  New-GPLink -Name $name -Target $DomainDN -LinkEnabled Yes | Out-Null
}
Write-Host "GPO '$name' créée/liée." -ForegroundColor Green
