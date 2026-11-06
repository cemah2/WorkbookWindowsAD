# Build — Implémenter AGDLP de bout en bout (dans CORP)

> On relie un utilisateur à une permission NTFS réelle en respectant AGDLP.

## Pré-requis
- Structure d'OU + groupes de départ (module 14). Un partage de fichiers (sera approfondi module 25).

## Étape 1 — Groupes rôle (global) & ressource (domain local)
```powershell
$g = "OU=Groups,DC=corp,DC=meridian,DC=com"
New-ADGroup -Name "R_Finance_EMEA"    -GroupScope Global      -GroupCategory Security -Path "OU=Roles,$g"
New-ADGroup -Name "RES_FS-Finance_RW" -GroupScope DomainLocal -GroupCategory Security -Path "OU=Resources,$g"
New-ADGroup -Name "RES_FS-Finance_RO" -GroupScope DomainLocal -GroupCategory Security -Path "OU=Resources,$g"
```

## Étape 2 — Chaîne AGDLP
```powershell
Add-ADGroupMember -Identity "R_Finance_EMEA"    -Members "jon.snow"           # A -> G
Add-ADGroupMember -Identity "RES_FS-Finance_RW" -Members "R_Finance_EMEA"     # G -> DL
```

## Étape 3 — Poser la permission sur la ressource (P)
```powershell
# Sur le serveur de fichiers : dossier C:\Shares\Finance
$path = "C:\Shares\Finance"
$acl = Get-Acl $path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
  "CORP\RES_FS-Finance_RW","Modify","ContainerInherit,ObjectInherit","None","Allow")
$acl.AddAccessRule($rule)
Set-Acl $path $acl
```

## Étape 4 — Vérifier l'accès effectif
```powershell
# Appartenances effectives de l'utilisateur
Get-ADPrincipalGroupMembership jon.snow | Select Name
# Qui est dans le groupe ressource ?
Get-ADGroupMember RES_FS-Finance_RW
# Permissions effectives du dossier
(Get-Acl $path).Access | Where-Object IdentityReference -match "RES_FS-Finance"
```
Teste : `jon.snow` accède en écriture au partage ; un non-membre, non.

## Pièges courants
- Poser la permission NTFS directement sur le **global** ou sur le **compte** (casse AGDLP).
- Confondre portée globale/domain local (une domain local n'est pas utilisable hors du domaine).
- Imbrications trop profondes (token bloat).
