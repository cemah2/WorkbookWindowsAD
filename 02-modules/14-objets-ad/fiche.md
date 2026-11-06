# Fiche — Les objets Active Directory

> Volet académique. Une fois le domaine créé (module 13), on le **peuple** : utilisateurs,
> groupes, ordinateurs, OU. Comprendre ces objets et leurs attributs est la base de tout.

## 1. Rôle & utilité

AD est une base d'objets structurée. Chaque objet appartient à une **classe** (user, group,
computer, organizationalUnit…) définie par le **schéma**, et porte des **attributs**
(`sAMAccountName`, `userPrincipalName`, `memberOf`…). Administrer AD, c'est créer, organiser et
sécuriser ces objets.

## 2. Les objets principaux

| Objet | Rôle | Identifiants clés |
|---|---|---|
| **User** | Compte d'une personne | `sAMAccountName` (SAM), `userPrincipalName` (UPN) |
| **Group** | Regroupe des comptes/ressources | portée + type (voir §4) |
| **Computer** | Compte d'une machine jointe | `sAMAccountName` finissant par `$` |
| **OU** | Conteneur d'organisation | cible des GPO et délégations |
| **Contact / gMSA / etc.** | Objets spécialisés | — |

## 3. Identité d'un objet : SID, GUID, noms

- **SID** (Security Identifier) : identifiant de sécurité unique, utilisé dans les ACL. Les
  comptes « bien connus » ont des **RID** fixes (ex. `-500` = Administrator, `-512` = Domain Admins).
- **objectGUID** : identifiant immuable (survit à un renommage/déplacement).
- **Distinguished Name (DN)** : chemin complet (`CN=Jon Snow,OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com`).
- **UPN** : `jon.snow@corp.meridian.com` (format de connexion moderne).

## 4. Groupes : portée & type (fondamental)

**Type** : *Sécurité* (porte des droits, apparaît dans les ACL) ou *Distribution* (listes mail).

**Portée** :
| Portée | Peut contenir | Utilisable où |
|---|---|---|
| **Domain Local** | comptes/globaux/universels de la forêt | permissions dans **son** domaine |
| **Global** | comptes/globaux de **son** domaine | partout dans la forêt |
| **Universal** | comptes/groupes de toute la forêt | partout (stocké au GC) |

> Modèle **AGDLP** (voir `architecture.md` §7) : *Account* → *Global* (rôle) → *Domain Local*
> (ressource) → *Permission*. C'est la bonne pratique d'imbrication.

## 5. Comptes & groupes sensibles (à connaître tôt)
- `Domain Admins`, `Enterprise Admins`, `Schema Admins`, `Administrators` → **Tier 0**.
- `Account Operators`, `Backup Operators`, `Server Operators`, `Print Operators`,
  `DnsAdmins` → privilèges puissants souvent sous-estimés.
- `Protected Users` → groupe **défensif** (durcit l'authentification des comptes sensibles).

## 6. Implémentation & outils
- **ADUC** (Users and Computers), **ADAC** (Administrative Center) : consoles GUI.
- Module PowerShell **`ActiveDirectory`** : `New-ADUser`, `New-ADGroup`, `Add-ADGroupMember`,
  `Get-ADUser -Filter`, `New-ADOrganizationalUnit`.
- Note Server 2025 : ADAC/ADUC n'autorisent plus la création de comptes « pré-2000 » par défaut.

## 7. Surface d'attaque (aperçu)
- Attributs abusables : `servicePrincipalName` (Kerberoasting), `userAccountControl`
  (DONT_REQ_PREAUTH → AS-REP roasting), `msDS-KeyCredentialLink` (Shadow Credentials).
- Appartenances excessives à des groupes sensibles = chemins vers le Tier 0 (BloodHound, P5/P7).
- Comptes de service avec SPN + mot de passe faible = cibles de Kerberoasting.

## 8. Détection (aperçu)
Création/modification d'objets et changements d'appartenance de groupes sensibles sont
journalisés (4720, 4728/4732/4756, 4738…). Voir `defend.md`.

## 9. Versioning (2016 → 2025)
- **gMSA** (2012+) puis **dMSA** (2025) pour les comptes de service.
- `Protected Users`, authentication policies/silos (2012 R2+) pour durcir le Tier 0.

## 10. Pour aller plus loin
Microsoft Learn — Manage AD objects ; *Mastering Active Directory* (objets, groupes).
Voir `99-ressources/bibliographie.md` (P1, P2).
