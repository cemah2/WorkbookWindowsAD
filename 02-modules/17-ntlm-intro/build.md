# Build — Observer, auditer et réduire NTLM (dans CORP)

> On ne casse rien ici : on **mesure** l'usage de NTLM et on prépare sa réduction.

## Pré-requis
- `corp.meridian.com` avec un client joint (module 14).

## Étape 1 — Voir NTLM en action
Accède à un partage **par IP** (force NTLM car pas de SPN résolu) :
```cmd
net use \\10.10.0.10\sysvol
klist            :: aucun ST pour cet accès -> NTLM a été utilisé
```
Compare avec un accès par **nom** (Kerberos → un ST apparaît).

## Étape 2 — Activer l'audit NTLM (sans bloquer)
Via GPO *Default Domain Controllers* / baseline :
`Network security: Restrict NTLM: Audit NTLM authentication in this domain = Enable all`.
Et sur les serveurs : *Audit Incoming NTLM Traffic = Enable auditing for all accounts*.

## Étape 3 — Lire les événements NTLM
```powershell
Get-WinEvent -LogName "Microsoft-Windows-NTLM/Operational" -MaxEvents 20 |
  Select TimeCreated, Id, Message
```

## Étape 4 — Imposer la signature SMB & LDAP (anti-relais)
```powershell
Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
```
LDAP signing/channel binding via GPO (voir module 15). Ces deux réglages cassent une grande
partie des **relais NTLM** (Phase 5).

## Étape 5 — (option) Désactiver LLMNR/NBT-NS (coupe Responder)
GPO : *Turn off multicast name resolution = Enabled* ; désactiver NetBIOS over TCP/IP.

## Vérification
```powershell
Get-SmbServerConfiguration | Select RequireSecuritySignature
Get-WinEvent -LogName "Microsoft-Windows-NTLM/Operational" -MaxEvents 5
```

## Pièges courants
- Bloquer NTLM d'un coup → casser des applications héritées. **Auditer d'abord**, restreindre ensuite.
