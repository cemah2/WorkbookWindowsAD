# Defend — Sécuriser un RODC

## Durcissement
1. **PRP minimale** : n'autoriser que les comptes réellement locaux à l'agence.
2. **Comptes sensibles/Tier 0 toujours en Denied** (jamais mis en cache sur un RODC).
3. **Filtered Attribute Set** pour empêcher la réplication d'attributs sensibles vers le RODC.
4. **Sécurité physique** du site (le RODC assume que le site est moins sûr).
5. Surveiller régulièrement les **comptes révélés** (`-RevealedAccounts`).

## Détection
| Événement | Source | Signal |
|---|---|---|
| Mise en cache d'un secret par le RODC | Security | 4768/4769 traités par le RODC + révélation |
| Tentative d'écriture sur le RODC | Directory Service | erreurs (lecture seule) |
| Compte sensible révélé | Audit PRP | `-RevealedAccounts` inattendu |

### Règle Sigma — compte sensible mis en cache sur un RODC (indice)
```yaml
title: Authentification d'un compte sensible via un RODC
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4768
    TargetUserName|startswith: 'adm-t0-'
  condition: selection
level: high
tags:
  - attack.credential_access
  - attack.t1003
```

## Preuve de détection (purple team)
Tente d'authentifier un compte sensible via le RODC et vérifie qu'il n'est pas mis en cache ;
alerte si un `adm-t0-*` apparaît dans les comptes révélés.

## Rejouer contre CORP durci
Avec une PRP stricte, le vol du RODC n'expose que quelques comptes d'agence, jamais le Tier 0.
