<#
.SYNOPSIS  Implémente une chaîne AGDLP + permission NTFS. Idempotent. Lab.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Role,          # groupe global (rôle)
  [Parameter(Mandatory)][string]$Resource,      # groupe domain local (ressource)
  [Parameter(Mandatory)][string]$Member,         # compte
  [Parameter(Mandatory)][string]$Path,           # dossier
  [ValidateSet("ReadAndExecute","Modify","FullControl")][string]$Rights = "Modify",
  [Parameter(Mandatory)][string]$GroupsOU
)
$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory
if (-not (Get-ADGroup -LDAPFilter "(cn=$Role)"))     { New-ADGroup -Name $Role -GroupScope Global -GroupCategory Security -Path "OU=Roles,$GroupsOU" }
if (-not (Get-ADGroup -LDAPFilter "(cn=$Resource)")) { New-ADGroup -Name $Resource -GroupScope DomainLocal -GroupCategory Security -Path "OU=Resources,$GroupsOU" }
Add-ADGroupMember -Identity $Role -Members $Member -ErrorAction SilentlyContinue
Add-ADGroupMember -Identity $Resource -Members $Role -ErrorAction SilentlyContinue
if (Test-Path $Path) {
  $acl = Get-Acl $Path
  $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$env:USERDOMAIN\$Resource",$Rights,"ContainerInherit,ObjectInherit","None","Allow")
  $acl.AddAccessRule($rule); Set-Acl $Path $acl
  Write-Host "AGDLP OK + permission $Rights sur $Path." -ForegroundColor Green
} else {
  Write-Warning "Chemin $Path introuvable : chaîne AGDLP créée, permission NTFS à poser sur le serveur de fichiers."
}
