# Defend — Protéger et surveiller les GPO

## Durcissement
1. **Droits d'édition de GPO = Tier 0** : restreindre qui peut créer/éditer/lier des GPO,
   surtout celles liées au domaine et aux OU de serveurs/DC.
2. **Aucun secret dans les GPO/GPP** ; purger tout **cpassword** hérité de SYSVOL.
3. **Backups de GPO** réguliers (`Backup-GPO`) pour restauration rapide.
4. **Baselines** signées (Microsoft Security Baselines / CIS) plutôt que réglages ad hoc.
5. Surveiller la cohérence **GPC/GPT** (versions) et les permissions des GPO.

## Détection
| Événement | Source | ID |
|---|---|---|
| Modification d'objet GPO (si audit objet) | Security | 5136 / 5137 / 5141 |
| Changement de gPLink sur OU/domaine | Security | 5136 |
| Écriture dans SYSVOL\Policies | Security (audit fichier) | 4663 |

### Règle Sigma — modification d'une GPO (attribut gPCMachineExtensionNames / versionNumber)
```yaml
title: Modification d'objet Group Policy
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    ObjectClass: 'groupPolicyContainer'
  condition: selection
level: high
tags:
  - attack.defense_evasion
  - attack.t1484.001
```

## Preuve de détection (purple team)
Modifie une GPO de test et vérifie le 5136 (audit "Directory Service Changes" activé) puis la
règle dans le SIEM (P7). Atomic Red Team propose des tests T1484.001.

## Rejouer contre CORP durci
Après restriction des droits d'édition, un compte non-Tier 0 ne peut plus modifier de GPO liée ;
SYSVOL ne contient plus de cpassword.
