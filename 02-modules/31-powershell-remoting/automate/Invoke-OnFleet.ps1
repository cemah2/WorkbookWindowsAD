<#
.SYNOPSIS  Exécute un scriptblock sur un parc de machines (fan-out robuste). Lab/entreprise.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string[]]$Computers,
  [Parameter(Mandatory)][scriptblock]$Script,
  [int]$ThrottleLimit = 32
)
$ErrorActionPreference = "Stop"
$results = Invoke-Command -ComputerName $Computers -ScriptBlock $Script `
  -ThrottleLimit $ThrottleLimit -ErrorAction SilentlyContinue -ErrorVariable errs
$results | Select-Object PSComputerName, * -ErrorAction SilentlyContinue
if ($errs) {
  Write-Warning "Échecs sur : $(( $errs | ForEach-Object { $_.TargetObject } ) -join ', ')"
}
