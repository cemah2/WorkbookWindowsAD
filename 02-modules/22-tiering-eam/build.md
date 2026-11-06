# Build — Mettre en place le tiering (dans CORP)

> On implémente le modèle Tier 0/1/2 : OU, comptes/groupes d'admin séparés, et GPO de deny logon
> croisées. C'est long mais structurant.

## Pré-requis
- OU `Admin/Tier0|Tier1|Tier2` (architecture.md §6), structure de base (modules 14, 20, 21).

## Étape 1 — Groupes d'admin par tier
```powershell
$admin = "OU=Admin,DC=corp,DC=meridian,DC=com"
New-ADGroup -Name "T0_Admins" -GroupScope Global -GroupCategory Security -Path "OU=Tier0,$admin"
New-ADGroup -Name "T1_Admins" -GroupScope Global -GroupCategory Security -Path "OU=Tier1,$admin"
New-ADGroup -Name "T2_Admins" -GroupScope Global -GroupCategory Security -Path "OU=Tier2,$admin"
```

## Étape 2 — Comptes d'admin dédiés (exemple pour toi)
```powershell
$pw = Read-Host -AsSecureString "Mot de passe admin T0"
New-ADUser -Name "adm-t0-mathieu" -SamAccountName "adm-t0-mathieu" `
  -UserPrincipalName "adm-t0-mathieu@corp.meridian.com" -Path "OU=Tier0,$admin" `
  -AccountPassword $pw -Enabled $true
Add-ADGroupMember -Identity "T0_Admins" -Members "adm-t0-mathieu"
# (répéter pour T1/T2 ; ces comptes ne servent QUE sur leur tier)
```

## Étape 3 — GPO de deny logon croisées (le cœur)
Crée 3 GPO (Tier0/Tier1/Tier2) qui définissent les droits
*Deny log on locally / through Remote Desktop Services / as a batch job / as a service*.

Exemple — GPO liée aux **DC (Tier 0)**, refuse T1 et T2 :
```
User Rights Assignment:
  Deny log on locally                = CORP\T1_Admins; CORP\T2_Admins
  Deny log on through RDS            = CORP\T1_Admins; CORP\T2_Admins
```
GPO liée aux **serveurs Tier 1**, refuse T0 et T2 :
```
  Deny log on locally                = CORP\T0_Admins; CORP\T2_Admins
  Deny log on through RDS            = CORP\T0_Admins; CORP\T2_Admins
```
GPO liée aux **postes Tier 2**, refuse T0 et T1 (idem, croisé).

> Application : lier chaque GPO à l'OU des machines du tier (DC, Servers/Tier1, Workstations).

## Étape 4 — Protected Users & (option) silo d'authentification Tier 0
```powershell
Add-ADGroupMember -Identity "Protected Users" -Members "adm-t0-mathieu"
# Silo (option avancée) :
New-ADAuthenticationPolicy -Name "T0-Policy" -UserTGTLifetimeMins 240 -ProtectedFromAccidentalDeletion $false
New-ADAuthenticationPolicySilo -Name "T0-Silo" -UserAuthenticationPolicy "T0-Policy" `
  -ComputerAuthenticationPolicy "T0-Policy" -ServiceAuthenticationPolicy "T0-Policy" -Enforce
# Puis assigner comptes/ordinateurs Tier 0 au silo.
```

## Étape 5 — PAW (principe)
Désigne un poste dédié à l'administration Tier 0 (durci, sans mail/web, dans le VLAN Tier 0 =
10.99.0.0/24). Les comptes T0 ne se connectent que depuis ce PAW.

## Vérification
```powershell
# Un compte T0 ne doit PAS pouvoir ouvrir de session sur un serveur T1/poste T2 :
# tester une connexion RDP T0 -> serveur T1  => refusée (deny logon)
Get-ADGroupMember T0_Admins
gpresult /h rsop.html   # sur un DC : vérifier les deny logon appliqués
```

## Pièges courants
- Se **verrouiller dehors** : toujours garder un accès d'urgence (ex. compte break-glass + console
  Proxmox) avant d'appliquer les deny logon sur les DC.
- Utiliser le compte T0 pour se connecter en T1 « juste une fois » → casse tout le modèle.
