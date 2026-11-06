# Build — Promouvoir le premier DC (à la main)

> On transforme `PAR-DC-01` (préparé au module 10) en premier contrôleur de la forêt
> `meridian.com` / domaine `corp.meridian.com`. Logique du workbook : **à la main ici**,
> **automatisé** dans `automate/`.

## Pré-requis
- `PAR-DC-01` installé, nommé, IP statique `10.10.0.10/16`, à jour (module 10).
- Mot de passe DSRM choisi (coffre KeePass, **hors Git**).

## Étape 1 — Ajouter le rôle AD DS (GUI)
1. **Server Manager → Manage → Add Roles and Features**.
2. Coche **Active Directory Domain Services** (accepte les fonctionnalités liées). Installe.
   *DNS sera proposé/ajouté pendant la promotion.*

## Étape 2 — Promouvoir en premier DC (GUI)
1. Dans Server Manager, bannière jaune → **Promote this server to a domain controller**.
2. **Add a new forest** → nom de domaine racine : `corp.meridian.com`.
   *(Note : ici la forêt racine « technique » prend le nom du premier domaine ; pour rester
   simple au départ, on crée directement `corp.meridian.com` comme domaine racine de forêt.)*
3. Niveaux fonctionnels **forêt/domaine : Windows Server 2016**.
4. Laisse **DNS** et **Global Catalog** cochés. Saisis le **mot de passe DSRM**.
5. NetBIOS : `CORP`. Chemins NTDS/SYSVOL : valeurs par défaut (lab).
6. Lance la vérification des prérequis, puis **Install** → redémarrage automatique.

## Étape 3 — Reconfigurer le DNS client
Après redémarrage, le DC doit se résoudre lui-même :
```powershell
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1
# Forwarder vers un résolveur amont (ex. OPNsense ou DNS public autorisé dans le lab)
Add-DnsServerForwarder -IPAddress 10.10.0.1
```

## Étape 4 — Vérification
```powershell
# Le serveur est-il bien DC ? rôle + domaine
Get-ADDomainController -Identity $env:COMPUTERNAME | Format-List Name,Domain,Forest,IsGlobalCatalog
Get-ADDomain  | Format-List DNSRoot,NetBIOSName,DomainMode
Get-ADForest  | Format-List Name,ForestMode,GlobalCatalogs

# Santé du DC
dcdiag /v

# Enregistrements SRV publiés par le DC
Resolve-DnsName -Type SRV _ldap._tcp.dc._msdcs.corp.meridian.com
```
Tout doit répondre sans erreur critique ; les SRV `_ldap`/`_kerberos` doivent exister.

## Étape 5 — Snapshot
Prends un snapshot **`dc-clean`** : point de retour propre avant d'ajouter des objets (module 14).

## Pièges courants
- **DNS client** laissé sur l'ancienne IP → `dcdiag` remonte des erreurs DNS.
- **Heure** décalée → problèmes Kerberos dès l'ajout de clients.
- Vouloir renommer le DC après coup → à éviter ; on nomme **avant** (module 10).
