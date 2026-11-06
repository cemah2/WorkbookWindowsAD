# Defend — Neutraliser le roasting

## Durcissement
1. **AES-only** (bannir RC4) sur les comptes de service (`msDS-SupportedEncryptionTypes`).
2. **gMSA/dMSA** : mots de passe longs/gérés, non cassables en pratique → tue le Kerberoasting.
3. **Supprimer DONT_REQ_PREAUTH** partout où il n'est pas justifié (anti AS-REP).
4. **Mots de passe forts** pour les comptes à SPN restants ; rotation.
5. **Réduire les SPN** inutiles.

## Détection
| Événement | Signal | ID |
|---|---|---|
| Demande de TGS | Kerberoasting (RC4, en volume, par un user) | 4769 (etype 0x17) |
| AS-REQ sans pré-auth | AS-REP roasting | 4768 (PreAuthType 0) |

### Règle Sigma — Kerberoasting (4769 RC4)
```yaml
title: Possible Kerberoasting (TGS RC4 pour comptes utilisateurs)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4769
    TicketEncryptionType: '0x17'
  filter:
    ServiceName|endswith: '$'
  timeframe: 10m
  condition: selection and not filter | count() by SubjectUserName > 10
level: high
tags:
  - attack.credential_access
  - attack.t1558.003
```

## Preuve de détection (purple team)
Rejoue le roasting (ou Atomic T1558.003/004) et vérifie 4769 RC4 / 4768 no-preauth + la règle (P7).

## Rejouer contre CORP durci
Avec AES-only + gMSA + suppression du no-preauth, le roasting ne renvoie plus de hashes cassables.
