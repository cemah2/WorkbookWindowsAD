# Defend — Un PRA qui tient

## Durcissement / bonnes pratiques
1. **Sauvegardes immuables/hors-ligne** (air-gap) de ≥ 2 DC, rétention < tombstone lifetime.
2. **AD Recycle Bin** activée.
3. **Tester** régulièrement les restaurations (objet, system state, VM, forest recovery sur table).
4. **Isoler** les sauvegardes du domaine (un compromis DA ne doit pas détruire les backups).
5. **Procédure Forest Recovery** documentée (rotation krbtgt x2, ordre de restauration).
6. Surveiller **suppressions massives** et démarrages **DSRM**.

## Détection
| Événement | Source | ID |
|---|---|---|
| Suppression d'objet AD | Security | 5141 |
| Suppression de clichés (vssadmin delete) | Security/Sysmon | 4688 (ligne de commande) |
| Démarrage en DSRM | System | — |
| Sauvegarde échouée/altérée | Backup logs | — |

### Règle Sigma — suppression des clichés instantanés (anti-recovery)
```yaml
title: Suppression des Volume Shadow Copies (inhibit recovery)
logsource:
  product: windows
  category: process_creation
detection:
  selection:
    Image|endswith: '\vssadmin.exe'
    CommandLine|contains|all:
      - 'delete'
      - 'shadows'
  condition: selection
level: critical
tags:
  - attack.impact
  - attack.t1490
```

## Preuve de détection (purple team)
Exécute `vssadmin delete shadows` en lab (sur une VM jetable) et vérifie le 4688/Sysmon + la règle.
Teste une restauration complète pour prouver le PRA.

## Rejouer contre CORP durci
Avec sauvegardes hors-ligne immuables et testées, même un chiffrement des DC permet une reprise.
