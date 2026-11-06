<#
.SYNOPSIS  Applique une baseline d'audit avancée (auditpol) pour la détection AD. Lab.
.NOTES     À déployer idéalement par GPO en prod (Advanced Audit Policy). Ici : application locale.
#>
[CmdletBinding()] param()
$ErrorActionPreference = "Stop"
$subs = @(
  "Kerberos Authentication Service","Kerberos Service Ticket Operations",
  "Credential Validation","Logon","Logoff","Account Lockout",
  "Directory Service Access","Directory Service Changes",
  "Process Creation","Security Group Management","User Account Management",
  "Certification Services"
)
foreach ($s in $subs) {
  & auditpol /set /subcategory:"$s" /success:enable /failure:enable | Out-Null
}
Write-Host "Baseline d'audit appliquée. Vérifie : auditpol /get /category:*" -ForegroundColor Green
