# Defend — Protéger et surveiller la réplication

## Durcissement
1. **Restreindre les droits de réplication** (*Replicating Directory Changes / All / In Filtered Set*)
   aux seuls DC — auditer qui les possède (BloodHound, `Get- Acl` sur le naming context).
2. Traiter tout principal avec ces droits comme **Tier 0**.
3. Surveiller l'ajout de DC / objets nTDSDSA (DCShadow).
4. Santé de réplication (pas de DC isolé/obsolète ; tombstone lifetime).

## Détection
| Événement | Source | ID / Signal |
|---|---|---|
| DCSync depuis un hôte non-DC | Security | 4662 (GUID de replication) depuis une IP non-DC |
| DCShadow (enregistrement de DC) | Security/Directory | 4928/4929, création nTDSDSA |
| Échecs/latence de réplication | DFS/Directory Service | repadmin |

### Règle Sigma — DCSync (réplication demandée par un non-DC)
```yaml
title: Possible DCSync (accès au droit de réplication par un principal non-DC)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4662
    Properties|contains:
      - '1131f6aa-9c07-11d1-f79f-00c04fc2dcd2'   # DS-Replication-Get-Changes
      - '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2'   # DS-Replication-Get-Changes-All
  filter:
    SubjectUserName|endswith: '$'   # exclure comptes machines (DC)
  condition: selection and not filter
level: critical
tags:
  - attack.credential_access
  - attack.t1003.006
```

## Preuve de détection (purple team)
Exécute un DCSync en lab (Phase 5) depuis un compte non-DC et vérifie le 4662 + la règle (P7).

## Rejouer contre CORP durci
Après restriction des droits de réplication, un compte compromis non autorisé ne peut plus
effectuer de DCSync.
