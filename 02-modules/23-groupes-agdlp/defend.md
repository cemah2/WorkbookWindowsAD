# Defend — Hygiène et surveillance des groupes

## Durcissement
1. **AGDLP strict** : permissions sur domain locals uniquement ; rôles = globaux.
2. **Revue des imbrications** vers les groupes sensibles (`Get-GroupSprawl.ps1`, BloodHound).
3. **Nettoyer** groupes vides/obsolètes ; limiter la profondeur d'imbrication (token bloat).
4. **Revues d'accès** périodiques (qui est dans quel groupe ressource).
5. Groupes sensibles traités en **Tier 0** (modules 21-22).

## Détection
| Événement | Source | ID |
|---|---|---|
| Ajout de membre (global/DL/universel) | Security | 4728 / 4732 / 4756 |
| Retrait de membre | Security | 4729 / 4733 / 4757 |
| Création/suppression de groupe | Security | 4727/4730, 4731/4734 |

### Règle Sigma — imbrication d'un groupe dans un groupe à privilèges
```yaml
title: Groupe imbriqué dans un groupe à privilèges
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID:
      - 4728
      - 4732
      - 4756
    TargetUserName:
      - 'Domain Admins'
      - 'Enterprise Admins'
      - 'Administrators'
  condition: selection
level: high
tags:
  - attack.persistence
  - attack.t1098
```

## Preuve de détection (purple team)
Ajoute un groupe de test dans "Administrators" (puis retire-le) et vérifie 4732 + la règle (P7).

## Rejouer contre CORP durci
Après nettoyage des imbrications, BloodHound ne montre plus de chemin d'escalade par groupe depuis
un compte standard.
