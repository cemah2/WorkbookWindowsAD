# Defend — Sécuriser les trusts

## Durcissement
1. **SID filtering (quarantine) activé** sur les forest/external trusts → ignore les sIDHistory étrangers.
2. **Selective Authentication** : n'autoriser l'accès cross-forest que là où c'est explicitement voulu.
3. **Minimiser la direction/transitivité** (éviter bidirectionnel large après M&A).
4. **Traiter la forêt la moins sûre comme hostile** jusqu'à sa mise à niveau.
5. Surveiller les **modifications de trust** et l'usage de **sIDHistory**.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Modification d'un trust | Security | 5136 (trustedDomain) / 4706-4716 |
| sIDHistory ajouté | Security | 4765/4766 |
| TGT inter-realm anormal | Security | 4769 cross-realm inattendu |
| Accès cross-domain inhabituel | Security | 4624 avec compte « foreign » |

### Règle Sigma — ajout de SID History
```yaml
title: Ajout de SID History (possible escalade cross-domain/forest)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID:
      - 4765
      - 4766
  condition: selection
level: high
tags:
  - attack.privilege_escalation
  - attack.t1134.005
```

## Preuve de détection (purple team)
Active le SID filtering et rejoue l'abus (lab) → échec ; vérifie 4765/4766 et 5136 lors des manips de
trust + les règles (P7).

## Rejouer contre CORP durci
Avec SID filtering + Selective Authentication + trust minimal, le pivot cross-forest via SID history
échoue et les tentatives sont détectées.
