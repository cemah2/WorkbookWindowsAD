# Defend — Protéger et exploiter Sysmon

## Durcissement
1. **Protéger le service Sysmon** (ACL, exécution, nom aléatoire possible) ; config centralisée/versionnée.
2. **Alerter sur l'arrêt/désinstallation** de Sysmon et la modification de sa config.
3. **Compléter par un EDR** (Sysmon n'est pas un EDR) ; LSA Protection/Credential Guard (module 56).
4. Forward immédiat vers le SIEM (module 70) ; intégrité des logs.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Sysmon arrêté | System | 7034/7040 (service), absence d'events |
| Config Sysmon modifiée | Sysmon | 16 (config change) |
| Erreurs Sysmon | Sysmon | 255 |
| Désinstallation | Sysmon/Security | 1 (sysmon -u), 4688 |

### Règle Sigma — modification de la configuration Sysmon
```yaml
title: Modification de la configuration Sysmon
logsource:
  product: windows
  service: sysmon
detection:
  selection:
    EventID: 16
  condition: selection
level: high
tags:
  - attack.defense_evasion
  - attack.t1562.001
```

## Preuve de détection (purple team)
Arrête Sysmon et modifie sa config (VM jetable), vérifie 7034/16 + alertes. Confirme que l'EDR voit
ce que Sysmon ne voit plus.

## Rejouer contre CORP durci
Service Sysmon protégé + alerte sur arrêt/config + EDR : la neutralisation de Sysmon est détectée et
partiellement compensée.
