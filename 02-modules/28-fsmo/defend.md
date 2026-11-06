# Defend — Surveiller et sécuriser les FSMO

## Durcissement / bonnes pratiques
1. **Placement réfléchi** : PDC+RID ensemble ; Schema+DNM sur un DC de forêt ; Infrastructure
   Master hors GC en multi-domaines (sauf "tous GC").
2. **DC = Tier 0** (modules 22, 26) ; protéger particulièrement le **PDC Emulator**.
3. **Temps fiable** : PDC synchronisé sur une source NTP de confiance.
4. **Procédure de récupération** documentée (transfert/saisie + metadata cleanup).
5. Surveiller tout **changement de détenteur** FSMO non planifié.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Transfert/saisie de rôle FSMO | Directory Service | changement de fSMORoleOwner |
| DCShadow / réplication anormale | Security | voir module 26 (4662) |
| Modif GPO via PDC | Security | 5136 (voir module 20) |

### Règle Sigma — changement de détenteur FSMO (indice)
```yaml
title: Changement de détenteur d'un rôle FSMO
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    AttributeLDAPDisplayName: 'fSMORoleOwner'
  condition: selection
level: high
tags:
  - attack.persistence
  - attack.t1207
```

## Preuve de détection (purple team)
Transfère un rôle FSMO de test et vérifie le 5136 sur `fSMORoleOwner` (audit DS Changes) + la règle.

## Rejouer contre CORP durci
Avec DC en Tier 0 et surveillance des changements FSMO, un transfert/saisie non planifié est
immédiatement visible.
