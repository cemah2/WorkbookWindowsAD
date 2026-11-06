# Defend — Une détection résiliente aux évasions

## Stratégie (synthèse Phase 8)
1. **Capteurs kernel + ETW-TI** (pas seulement user-mode) → résistants à l'unhooking.
2. **Tamper protection** + alerte sur arrêt/désinstallation de l'EDR/Sysmon.
3. **WDAC/ASR** : bloquer code non signé, driver BYOVD, comportements Office→child.
4. **Détection comportementale** (séquences ATT&CK) > IoC seuls.
5. **Defense-in-depth** : EDR + Sysmon + SIEM + hunting (les angles morts se recoupent).
6. **Purple team continu** (module 74) : re-tester face aux évasions.

## Détection
| Signal | Source |
|---|---|
| Arrêt/désinstallation EDR/Sysmon | System 7034/7040, EDR self-protection |
| Chargement driver vulnérable (BYOVD) | Sysmon 6 / EDR kernel |
| Incohérence télémétrie (process sans events) | corrélation SIEM |
| Séquence comportementale malveillante | EDR comportemental |

### Règle Sigma — arrêt d'un service de sécurité (EDR/Sysmon)
```yaml
title: Arrêt d'un service de sécurité (EDR/Sysmon)
logsource:
  product: windows
  service: system
detection:
  selection:
    EventID: 7036
    ServiceName|contains:
      - 'Sysmon'
      - 'Sense'          # Defender for Endpoint
      - 'WinDefend'
    State: 'stopped'
  condition: selection
level: high
tags:
  - attack.defense_evasion
  - attack.t1562.001
```

## Preuve de détection (purple team)
Rejoue (lab) une tentative de tampering/BYOVD et une évasion ETW/AMSI ; vérifie que **au moins une
couche** détecte, et remplis `edr-coverage.md`. Les trous = backlog prioritaire.

## Rejouer contre CORP durci
Avec tamper protection + capteurs kernel + WDAC + multi-sources, désactiver l'EDR devient difficile et
**bruyant** (détecté par une autre couche).
