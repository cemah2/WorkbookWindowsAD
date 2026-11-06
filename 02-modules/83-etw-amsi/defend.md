# Defend — Détecter le contournement de la télémétrie

## Durcissement / stratégie
1. **Multiplier les sources** : ETW user-mode **+ ETW-TI kernel + Sysmon + EDR comportemental** → pas
   de point unique contournable.
2. **Script Block Logging + transcription** (module 30) ; AMSI activé (Defender/AV à jour).
3. **WDAC/ASR** pour limiter l'exécution de code non signé (réduit les bypass).
4. **Surveiller l'intégrité** de la télémétrie (sessions ETW, service Sysmon, logging PS).
5. **EDR avec capteurs kernel** (module 84).

## Détection
| Signal | Source |
|---|---|
| Process actif mais events ETW absents (incohérence) | corrélation SIEM |
| Chaînes de bypass AMSI connues | 4104 / EDR |
| Échec d'init AMSI | Defender / AMSI logs |
| Session ETW stoppée / provider désactivé | logman / EDR |
| Modification mémoire de ntdll/amsi | EDR / ETW-TI |

### Règle Sigma — indice d'AMSI bypass dans un script block
```yaml
title: Indice d'AMSI bypass (chaînes connues dans un script block)
logsource:
  product: windows
  service: powershell
detection:
  selection:
    EventID: 4104
    ScriptBlockText|contains:
      - 'amsiInitFailed'
      - 'AmsiScanBuffer'
      - 'System.Management.Automation.AmsiUtils'
  condition: selection
level: high
tags:
  - attack.defense_evasion
  - attack.t1562.001
```

## Preuve de détection (purple team)
Rejoue un AMSI bypass connu (lab, Atomic si dispo) et vérifie le 4104 / la règle. Teste la détection
par **absence** (couper le logging et constater l'anomalie).

## Rejouer contre CORP durci
Multi-sources (ETW-TI + EDR kernel + Sysmon) + WDAC : le contournement d'une source laisse des traces
dans les autres et devient détectable.
