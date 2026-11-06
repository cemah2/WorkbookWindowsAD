<#
.SYNOPSIS  Installe/autorise DHCP et crée une étendue. Idempotent. Lab uniquement.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$ServerFqdn,
  [Parameter(Mandatory)][string]$ServerIp,
  [Parameter(Mandatory)][string]$ScopeId,
  [Parameter(Mandatory)][string]$Start,
  [Parameter(Mandatory)][string]$End,
  [Parameter(Mandatory)][string]$Mask,
  [Parameter(Mandatory)][string]$Router,
  [Parameter(Mandatory)][string]$Dns,
  [Parameter(Mandatory)][string]$DnsDomain
)
$ErrorActionPreference = "Stop"
Install-WindowsFeature DHCP -IncludeManagementTools | Out-Null
Import-Module DhcpServer
if (-not (Get-DhcpServerInDC | Where-Object IPAddress -eq $ServerIp)) {
  Add-DhcpServerInDC -DnsName $ServerFqdn -IPAddress $ServerIp
}
if (-not (Get-DhcpServerv4Scope -ScopeId $ScopeId -ErrorAction SilentlyContinue)) {
  Add-DhcpServerv4Scope -Name "Scope-$ScopeId" -StartRange $Start -EndRange $End -SubnetMask $Mask -State Active
}
Set-DhcpServerv4OptionValue -ScopeId $ScopeId -Router $Router -DnsServer $Dns -DnsDomain $DnsDomain
Write-Host "Baseline DHCP appliquee ($ScopeId)." -ForegroundColor Green
