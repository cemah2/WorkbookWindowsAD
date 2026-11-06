# Defend — Sécuriser et surveiller DFS/partages

## Durcissement
1. **AGDLP strict** sur les partages (jamais Everyone/Full) ; NTFS + share permissions cohérentes.
2. **Access-Based Enumeration (ABE)** : masquer ce que l'utilisateur ne peut pas voir.
3. **Signature SMB** requise (modules 10/17) ; désactiver SMBv1.
4. **Sauvegardes/snapshots** (VSS) pour récupérer après chiffrement.
5. Surveiller la **santé DFS-R** (backlog, conflits).

## Détection
| Événement | Source | ID |
|---|---|---|
| Accès à un fichier (si audit) | Security | 4663 |
| Connexion à un partage | Security | 5140 / 5145 |
| Modifications massives (rançongiciel) | Security/FSRM | 4663 en volume |
| Santé DFS-R | DFS Replication log | — |

### Règle Sigma — modifications massives de fichiers (indice rançongiciel)
```yaml
title: Volume anormal de modifications de fichiers sur partage
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4663
    AccessMask: '0x2'     # WriteData
  timeframe: 1m
  condition: selection | count() by SubjectUserName > 100
level: high
tags:
  - attack.impact
  - attack.t1486
```

## Preuve de détection (purple team)
Génère un lot d'écritures/renommages sur un partage de test et vérifie le pic de 4663 + la règle
(P7). Un File Server Resource Manager (FSRM) screen peut aussi détecter des extensions connues.

## Rejouer contre CORP durci
Avec AGDLP + ABE + SMB signé, un compte standard ne découvre plus de données sensibles ouvertes,
et les snapshots permettent la récupération.
