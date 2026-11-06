# Defend — Durcir et journaliser PowerShell

## Durcissement
1. **Script Block Logging** + **Module Logging** + **Transcription** (par GPO).
2. **Constrained Language Mode** (via AppLocker/WDAC) pour limiter les capacités.
3. **ExecutionPolicy** = `RemoteSigned`/`AllSigned` (rappel : ce n'est PAS une barrière de sécurité,
   juste un garde-fou — le vrai contrôle est WDAC/AppLocker + AMSI).
4. **AMSI** activé (antimalware scan) ; EDR.
5. Supprimer **PowerShell v2** (déprécié, contourne le logging moderne).

## Détection
| Événement | Log | ID |
|---|---|---|
| Script Block Logging | Microsoft-Windows-PowerShell/Operational | 4104 |
| Module Logging | idem | 4103 |
| Démarrage powershell (ligne de commande) | Security/Sysmon | 4688 / Sysmon 1 |
| Commande encodée | 4104/4688 | `-EncodedCommand` |

### Règle Sigma — PowerShell encodé (indice d'obfuscation)
```yaml
title: Exécution PowerShell avec commande encodée
logsource:
  product: windows
  category: process_creation
detection:
  selection:
    Image|endswith: '\powershell.exe'
    CommandLine|contains:
      - '-enc '
      - '-EncodedCommand'
      - '-e '
  condition: selection
level: medium
tags:
  - attack.execution
  - attack.t1059.001
```

## Preuve de détection (purple team)
Active le Script Block Logging (GPO), lance une commande encodée bénigne, vérifie le 4104/4688 +
la règle (P7). Atomic Red Team T1059.001 propose des tests.

## Rejouer contre CORP durci
Avec logging + AMSI + WDAC, les commandes encodées/obfusquées sont tracées et limitées.
