<#
.SYNOPSIS  Connexion Microsoft Graph avec les scopes de lab.
#>
[CmdletBinding()] param()
if (-not (Get-Module -ListAvailable Microsoft.Graph)) { Install-Module Microsoft.Graph -Scope CurrentUser -Force }
Connect-MgGraph -Scopes @(
  "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All",
  "RoleManagement.ReadWrite.Directory","Application.ReadWrite.All","AuditLog.Read.All"
)
(Get-MgContext) | Select Account, Scopes
