# Build — Interroger et sécuriser LDAP (dans CORP)

## Pré-requis
- `corp.meridian.com` peuplé (module 14). Outils : `ldp.exe` (Windows), `ldapsearch` (Linux).

## Étape 1 — Première requête authentifiée (PowerShell)
```powershell
# Recherche sub depuis la racine : tous les users activés
Get-ADUser -Filter {Enabled -eq $true} -SearchBase "DC=corp,DC=meridian,DC=com" -SearchScope Subtree |
  Select Name,SamAccountName
```

## Étape 2 — Requête LDAP "brute" (comprendre le protocole)
```powershell
# Via .NET DirectorySearcher : filtre LDAP explicite
$ds = [adsisearcher]"(&(objectClass=user)(servicePrincipalName=*))"
$ds.SearchRoot = [adsi]"LDAP://DC=corp,DC=meridian,DC=com"
$ds.FindAll() | ForEach-Object { $_.Properties.samaccountname }
```
Depuis Linux (lab) :
```bash
ldapsearch -x -H ldaps://10.10.0.10 -D "jon.snow@corp.meridian.com" -W \
  -b "DC=corp,DC=meridian,DC=com" "(objectClass=user)" sAMAccountName
```

## Étape 3 — Exiger la signature LDAP (durcissement)
Via GPO *Default Domain Controllers Policy* :
`Domain controller: LDAP server signing requirements = Require signing`, et activer le
**channel binding**. (Pré-requis défensif majeur pour la Phase 5, relais NTLM.)

## Étape 4 — Vérifier LDAPS (port 636)
```powershell
# LDAPS nécessite un certificat sur le DC (PKI en Phase 4 ; cert auto possible en lab)
Test-NetConnection 10.10.0.10 -Port 636
```

## Vérification
```powershell
# Les requêtes authentifiées fonctionnent ; les binds anonymes sont refusés (voir defend.md)
Get-ADRootDSE | Select ldapServiceName,supportedLDAPVersion
```

## Pièges courants
- Chercher avec un **baseDN** trop large ou un filtre non indexé → requêtes lentes.
- LDAPS cassé faute de certificat valide sur le DC.
