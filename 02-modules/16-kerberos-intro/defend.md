# Defend — Durcir et surveiller Kerberos

## Durcissement
1. **AES partout**, bannir **RC4** (`msDS-SupportedEncryptionTypes`) — complique le Kerberoasting.
2. **Comptes de service en gMSA/dMSA** (mots de passe longs/gérés, non cassables en pratique).
3. **Supprimer DONT_REQ_PREAUTH** inutile (anti AS-REP roasting).
4. **Protéger krbtgt** : rotation régulière du mot de passe krbtgt (2x), traiter les DC en Tier 0.
5. **Protected Users** pour les comptes sensibles (force AES, bloque délégation/NTLM).
6. **Heure** fiable (source NTP du PDC) — évite les faux positifs et les pannes.

## Détection
| Événement | Signal | ID |
|---|---|---|
| Demande de ST | Kerberoasting (surtout RC4, en volume) | 4769 |
| Demande de TGT | Activité anormale / TGT forgé | 4768 |
| Échec de pré-auth | Spraying / AS-REP enumeration | 4771 |
| Ticket au chiffrement RC4 | Downgrade suspect | 4769 (EncryptionType 0x17) |

### Règle Sigma — Kerberoasting (4769 RC4 en volume)
```yaml
title: Possible Kerberoasting (4769 RC4 pour comptes à SPN)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4769
    TicketEncryptionType: '0x17'   # RC4
  filter:
    ServiceName|endswith: '$'       # exclure comptes machines
  timeframe: 10m
  condition: selection and not filter | count() by IpAddress > 10
level: high
tags:
  - attack.credential_access
  - attack.t1558.003
```

## Preuve de détection (purple team)
Rejoue un Kerberoasting en lab (Rubeus/impacket, Phase 5) ou un test Atomic T1558.003, puis
vérifie les 4769 RC4 et le déclenchement de la règle dans le SIEM (P7).

## Rejouer contre CORP durci
Avec AES imposé + gMSA, un Kerberoasting ne renvoie plus de tickets RC4 faciles à casser, et le
compte de service n'a pas de mot de passe devinable.
