# Defend — Réduire et surveiller les privilèges

## Durcissement
1. **Moindre privilège** : retirer SeImpersonate/SeDebug/SeBackup des comptes/sessions qui n'en ont
   pas besoin (User Rights Assignment via GPO).
2. **gMSA/dMSA** pour les services ; limiter les comptes de service à privilèges.
3. **Tiering** (module 22) : les privilèges puissants restent au bon tier.
4. **Credential Guard** (limite l'intérêt de SeDebug sur LSASS) ; **WDAC** (limite SeLoadDriver/BYOVD).

## Détection
| Événement | Source | ID |
|---|---|---|
| Attribution de privilèges spéciaux à l'ouverture de session | Security | 4672 |
| Ajustement de privilèges du token | Security | 4703 |
| Service enfantant un shell SYSTEM (Potato) | Sysmon | 1 (lineage service->cmd/powershell en SYSTEM) |

### Règle Sigma — process SYSTEM enfanté par un service de façon suspecte (indice Potato)
```yaml
title: Shell SYSTEM enfanté par un process de service (possible abus SeImpersonate)
logsource:
  product: windows
  service: sysmon
detection:
  selection:
    EventID: 1
    IntegrityLevel: 'System'
    ParentImage|endswith:
      - '\w3wp.exe'
      - '\sqlservr.exe'
      - '\svchost.exe'
    Image|endswith:
      - '\cmd.exe'
      - '\powershell.exe'
  condition: selection
level: high
tags:
  - attack.privilege_escalation
  - attack.t1134
```

## Preuve de détection (purple team)
Rejoue une escalade SeImpersonate en lab (ou Atomic pertinent) et vérifie 4672 + le lineage Sysmon +
la règle (module 74).

## Rejouer contre CORP durci
Comptes de service en gMSA + privilèges réduits + Credential Guard : les escalades locales (Potato,
dump LSASS) deviennent difficiles et détectées.
