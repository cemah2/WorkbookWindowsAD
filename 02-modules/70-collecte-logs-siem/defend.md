# Defend — Une collecte résiliente

## Durcissement
1. **Forward au fil de l'eau** (WEF/agent) → les logs quittent l'endpoint avant tout effacement.
2. **SIEM = Tier 0-like** : accès restreint, intégrité, sauvegardes.
3. **Alerter sur l'anti-forensics** : 1102 (clear), arrêt EventLog/Sysmon, modif d'audit.
4. **Audit policy par GPO** (uniforme, non désactivable par un user).
5. **Rétention** suffisante + protection contre la falsification.

## Détection
| Événement | Log | ID |
|---|---|---|
| Journal Security effacé | Security | 1102 |
| Journal (autre) effacé | System | 104 |
| Service de log arrêté/altéré | System/Sysmon | 7034/7040, Sysmon 1 |
| Audit désactivé | Security | 4719 (audit policy changed) |

### Règle Sigma — effacement du journal Security
```yaml
title: Journal d'événements Security effacé
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 1102
  condition: selection
level: high
tags:
  - attack.defense_evasion
  - attack.t1070.001
```

## Preuve de détection (purple team)
Efface un journal (VM jetable) et désactive une catégorie d'audit, vérifie 1102/4719 + les alertes.

## Rejouer contre CORP durci
Avec forward immédiat + alerte 1102 + SIEM protégé, l'effacement local ne détruit plus les preuves et
déclenche une alerte.
