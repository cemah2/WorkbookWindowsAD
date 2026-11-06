# Defend — Sécuriser Ansible

## Durcissement
1. **Contrôleur Ansible = Tier 0-sensible** : accès restreint, durci, surveillé.
2. **Ansible Vault** avec mot de passe fort / gestion de secrets externe ; jamais de secret en clair
   (ni dans le dépôt — voir .gitignore).
3. **Kerberos** plutôt que NTLM/CredSSP pour les connexions Windows.
4. **Revue de code** des playbooks (comme du code applicatif) ; versionner.
5. **WinRM segmenté** (module 31) + respect du tiering.

## Détection
| Événement | Source | ID |
|---|---|---|
| Connexions WinRM depuis le contrôleur | Security | 4624 (type 3, wsmprovhost) |
| Exécutions distantes en rafale | Sysmon/Security | 4688 / Sysmon 1 |
| Modif de playbook/inventaire | Git / SIEM | — |

### Règle Sigma — vague de connexions WinRM depuis un seul hôte (orchestration suspecte)
```yaml
title: Rafale de connexions WinRM depuis un hôte unique
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4624
    LogonType: 3
    ProcessName|endswith: '\wsmprovhost.exe'
  timeframe: 5m
  condition: selection | count() by IpAddress > 20
level: medium
tags:
  - attack.lateral_movement
  - attack.t1021.006
```

## Preuve de détection (purple team)
Lance un playbook sur plusieurs cibles et observe la rafale de 4624 (wsmprovhost) ; ajuste le seuil
pour distinguer l'orchestration légitime d'un abus.

## Rejouer contre CORP durci
Contrôleur isolé + Vault fort + Kerberos : un accès partiel ne livre pas les clés du parc.
