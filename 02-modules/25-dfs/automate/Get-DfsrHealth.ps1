<#
.SYNOPSIS  État DFS-R + backlog entre deux membres (surveillance). Lecture seule.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Group,
  [Parameter(Mandatory)][string]$Folder,
  [Parameter(Mandatory)][string]$Source,
  [Parameter(Mandatory)][string]$Destination
)
$ErrorActionPreference = "Stop"
Get-DfsrState -ComputerName $Source | Select Path, UpdateState, Inbound | Format-Table -Auto
Get-DfsrBacklog -GroupName $Group -FolderName $Folder -SourceComputerName $Source `
  -DestinationComputerName $Destination
