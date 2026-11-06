# Fiche — Tokens d'accès & privilèges

> Volet académique. Le token d'accès est la « carte d'identité » d'un process : qui il est et ce qu'il
> peut faire. Comprendre les tokens explique l'escalade locale et l'impersonation. Orienté détection.

## 1. Rôle & utilité
Quand un utilisateur s'authentifie, Windows crée un **access token** attaché à ses process. Le **SRM**
compare ce token aux **ACL** des objets pour autoriser/refuser. Manipuler un token = changer d'identité.

## 2. Contenu d'un token
- **SID de l'utilisateur** + **SID des groupes** (dont bien connus : Administrators…).
- **Privilèges** (SeXxxPrivilege) et leur état (enabled/disabled).
- **Integrity level** (Low/Medium/High/System), **session**, type (primary vs impersonation).

## 3. Privilèges sensibles (escalade locale)
```mermaid
graph TD
    SeDebug[SeDebugPrivilege] --> L[Accès mémoire d'autres process -> dump LSASS]
    SeImpersonate[SeImpersonatePrivilege] --> P[Impersonation -> "Potato" -> SYSTEM]
    SeBackup[SeBackupPrivilege] --> F[Lire tout fichier -> SAM/NTDS]
    SeRestore[SeRestorePrivilege] --> W[Écrire partout]
    SeTakeOwnership[SeTakeOwnershipPrivilege] --> O[S'approprier des objets]
    SeLoadDriver[SeLoadDriverPrivilege] --> K[Charger un driver -> kernel/BYOVD]
```
- **SeDebugPrivilege** : ouvrir n'importe quel process (dump LSASS).
- **SeImpersonatePrivilege** : à la base des attaques « Potato » (service → SYSTEM) — fréquent sur les
  comptes de service.
- **SeBackup/SeRestore** : contourner les ACL (lire SAM/NTDS, écrire partout).
- **SeLoadDriver** : charger un driver (voie vers le kernel / BYOVD).

## 4. Types de tokens & impersonation
- **Primary token** (du process) vs **impersonation token** (un thread emprunte une identité).
- **Token theft/impersonation** : dupliquer un token d'un process plus privilégié → agir en son nom.

## 5. Observation
- `whoami /all` (SID/groupes/privilèges), `whoami /priv`.
- Process Explorer (onglet Security d'un process), API `OpenProcessToken`.

## 6. Objets/éléments liés
- Token, SID, privilèges, integrity level ; droits utilisateur (User Rights Assignment, GPO) qui
  **accordent** certains privilèges (lien tiering, module 22).

## 7. Surface d'attaque
- Comptes de service avec **SeImpersonate** → SYSTEM (Potato).
- **SeDebug** → dump LSASS (module 56).
- Privilèges accordés trop largement par GPO.

## 8. Détection (aperçu)
Attribution/usage de privilèges sensibles (4672 special privileges), 4703 (adjust token), process
anormaux obtenant SYSTEM. Voir `defend.md`.

## 9. Versioning
Les comptes de service modernes (gMSA/dMSA) et le retrait de privilèges inutiles réduisent la surface.
Les attaques « Potato » évoluent (JuicyPotato, RoguePotato, PrintSpoofer…).

## 10. Pour aller plus loin
*Windows Security Internals* (Forshaw — tokens), The Hacker Recipes (priv esc). Voir `bibliographie.md` (P8).
