# Defend — Sécuriser DHCP

## Durcissement
1. **Autorisation AD** obligatoire (serveurs Windows) — limite les rogues internes.
2. **DHCP Snooping** sur les switches (laisser passer les réponses DHCP uniquement des ports de confiance).
3. **Port security / 802.1X** contre la starvation (limiter les MAC par port).
4. **Mises à jour DNS via DHCP** : utiliser un compte dédié + "secure only" côté DNS.
5. **Failover** pour la disponibilité.

## Détection
| Événement | Source | ID |
|---|---|---|
| Autorisation/dé-autorisation DHCP | System / DHCP | 1044/1045 |
| Pénurie d'adresses (pool épuisé) | DHCP audit | — |
| Serveur DHCP non autorisé détecté | DHCP | 1042 |

### Règle Sigma — serveur DHCP non autorisé
```yaml
title: Serveur DHCP non autorisé détecté
logsource:
  product: windows
  service: system
detection:
  selection:
    Provider_Name: 'Microsoft-Windows-DHCP-Server'
    EventID: 1042
  condition: selection
level: high
tags:
  - attack.t1557
```

## Preuve de détection (purple team)
Simule un rogue en lab, vérifie l'alerte 1042 / le snooping, puis la règle dans le SIEM (P7).

## Rejouer contre le réseau durci
Avec DHCP snooping actif, le rogue ne doit plus être servi aux clients.
