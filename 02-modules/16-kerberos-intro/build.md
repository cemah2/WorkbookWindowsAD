# Build — Observer Kerberos en fonctionnement (dans CORP)

> Pas d'attaque ici : on **observe** le protocole pour le comprendre avant la Phase 5.

## Pré-requis
- `corp.meridian.com` avec au moins un client joint et un utilisateur (module 14).

## Étape 1 — Voir ses tickets
Sur un client, connecté en tant qu'utilisateur du domaine :
```cmd
klist                       :: liste TGT + STs en cache
klist purge                 :: vide le cache (pour réobserver)
```
Accède à un partage (`\\par-dc-01\sysvol`) puis `klist` à nouveau : un **ST** pour `cifs/...` apparaît.

## Étape 2 — Forcer AES et vérifier
```powershell
# Sur un compte, imposer AES et retirer RC4 (bonnes pratiques)
Set-ADUser svc-app01 -KerberosEncryptionType AES128,AES256
Get-ADUser svc-app01 -Properties msDS-SupportedEncryptionTypes
```

## Étape 3 — Activer l'audit Kerberos (préparer la détection)
Via GPO *Domain Controllers* → Advanced Audit Policy →
*Account Logon* → **Audit Kerberos Authentication Service** et **Service Ticket Operations** (Success/Failure).

## Étape 4 — Observer les événements
```powershell
Get-WinEvent -FilterHashtable @{LogName='Security';Id=4768,4769,4771} -MaxEvents 20 |
  Select TimeCreated,Id,@{n='Account';e={$_.Properties[0].Value}}
```

## Vérification
```cmd
klist                       :: TGT présent, ST créés à la demande
```
Les événements 4768/4769 apparaissent côté DC lors des authentifications.

## Pièges courants
- **Heure** décalée > 5 min → erreurs Kerberos (KRB_AP_ERR_SKEW).
- Dépendance **DNS/SPN** : un SPN mal enregistré casse l'obtention du ST (fallback NTLM).
