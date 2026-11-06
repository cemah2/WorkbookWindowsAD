# Build — Prendre en main un tenant Entra (lab)

## Pré-requis
- Un **tenant Entra persistant** (Azure free + essai Entra ID P2 pour CA/PIM). Un compte Global Admin
  de lab. PowerShell 7.

## Étape 1 — Outils d'administration
```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.ReadWrite.All","RoleManagement.ReadWrite.Directory"
# (Azure CLI en complément : az login)
```

## Étape 2 — Explorer le tenant
```powershell
Get-MgOrganization | Select DisplayName, Id
Get-MgUser -Top 10 | Select DisplayName, UserPrincipalName, AccountEnabled
Get-MgDirectoryRole | Select DisplayName, Id             # rôles activés
```

## Étape 3 — Créer des identités de lab
```powershell
$pw = @{ Password = 'TempP@ss!123'; ForceChangePasswordNextSignIn = $true }
New-MgUser -DisplayName "Cloud User" -UserPrincipalName "cloud.user@<tenant>.onmicrosoft.com" `
  -MailNickname "cloud.user" -AccountEnabled -PasswordProfile $pw
New-MgGroup -DisplayName "G_Cloud_Test" -MailEnabled:$false -SecurityEnabled -MailNickname "gcloudtest"
```

## Étape 4 — Observer rôles & app registrations
```powershell
Get-MgRoleManagementDirectoryRoleAssignment | Select PrincipalId, RoleDefinitionId
Get-MgApplication -Top 10 | Select DisplayName, AppId
Get-MgServicePrincipal -Top 10 | Select DisplayName, AppId, ServicePrincipalType
```

## Étape 5 — Lire les logs (base de la détection)
```powershell
Get-MgAuditLogSignIn -Top 10 | Select CreatedDateTime, UserPrincipalName, AppDisplayName, Status
Get-MgAuditLogDirectoryAudit -Top 10 | Select ActivityDisplayName, InitiatedBy
```

## Vérification
```powershell
(Get-MgContext).Scopes      # les scopes accordés
Get-MgUser -Top 1           # l'accès Graph fonctionne
```

## Pièges courants
- Confondre rôles **Entra** (annuaire) et **Azure RBAC** (ressources).
- Utiliser un sandbox ACG (jetable) pour l'hybride (la synchro casse au reset) — tenant persistant requis.
- Scopes Graph insuffisants → appels refusés.
