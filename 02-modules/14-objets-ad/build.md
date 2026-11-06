# Build — Peupler le domaine : OU, utilisateurs, groupes (dans CORP)

> On met en place une première structure conforme à `architecture.md` (§6-7) : OU géographiques,
> quelques utilisateurs, groupes de rôle (global) et de ressource (domain local), imbrication AGDLP.

## Pré-requis
- `corp.meridian.com` opérationnel (module 13), module `ActiveDirectory` présent
  (`Install-WindowsFeature RSAT-AD-PowerShell` si besoin).

## Étape 1 — Créer la structure d'OU (extrait)
```powershell
$base = "DC=corp,DC=meridian,DC=com"
New-ADOrganizationalUnit -Name "Employees" -Path $base
foreach ($r in "EMEA","AMER","APAC") {
  New-ADOrganizationalUnit -Name $r -Path "OU=Employees,$base"
}
New-ADOrganizationalUnit -Name "Groups" -Path $base
New-ADOrganizationalUnit -Name "Roles"     -Path "OU=Groups,$base"
New-ADOrganizationalUnit -Name "Resources" -Path "OU=Groups,$base"
```
> Astuce : décoche "Protect from accidental deletion" seulement en lab si tu dois rejouer souvent.

## Étape 2 — Créer des utilisateurs (GUI puis script)
GUI (ADUC) pour en créer **un** à la main et voir les champs (SAM, UPN, mot de passe, OU cible).
Puis en PowerShell :
```powershell
$pw = Read-Host -AsSecureString "Mot de passe initial"
New-ADUser -Name "Jon Snow" -GivenName "Jon" -Surname "Snow" `
  -SamAccountName "jon.snow" -UserPrincipalName "jon.snow@corp.meridian.com" `
  -Path "OU=EMEA,OU=Employees,$base" -AccountPassword $pw -Enabled $true `
  -ChangePasswordAtLogon $true
```

## Étape 3 — Groupes AGDLP
```powershell
# Groupe de RÔLE (global) et groupe de RESSOURCE (domain local)
New-ADGroup -Name "R_Finance_EMEA"   -GroupScope Global      -GroupCategory Security -Path "OU=Roles,OU=Groups,$base"
New-ADGroup -Name "RES_FS-Finance_RW" -GroupScope DomainLocal -GroupCategory Security -Path "OU=Resources,OU=Groups,$base"

# A → G : l'utilisateur entre dans le groupe de rôle
Add-ADGroupMember -Identity "R_Finance_EMEA" -Members "jon.snow"
# G → DL : le groupe de rôle entre dans le groupe de ressource
Add-ADGroupMember -Identity "RES_FS-Finance_RW" -Members "R_Finance_EMEA"
# DL → P : (la permission NTFS sur le partage se posera au module DFS/fichiers)
```

## Étape 4 — Créer un compte de service (gMSA) — aperçu
```powershell
# Prérequis : clé racine KDS (une fois par forêt)
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))   # en lab, effet immédiat
New-ADServiceAccount -Name "svc-app01" -DNSHostName "app01.corp.meridian.com" `
  -PrincipalsAllowedToRetrieveManagedPassword "PAR-DC-01$"
```

## Vérification
```powershell
Get-ADOrganizationalUnit -Filter * | Select Name,DistinguishedName
Get-ADUser jon.snow -Properties MemberOf | Select SamAccountName,UserPrincipalName,MemberOf
Get-ADGroupMember RES_FS-Finance_RW                      # doit contenir R_Finance_EMEA
Get-ADUser jon.snow | Select SID                         # identité de sécurité
```

## Pièges courants
- Confondre **type** (sécurité/distribution) et **portée** (global/DL/universel) d'un groupe.
- Mettre les comptes directement dans des groupes de ressource (casse le modèle AGDLP).
- Oublier `Add-KdsRootKey` avant un gMSA (erreur à la création).
