# Defend — Sécuriser le remoting

## Durcissement
1. **Segmenter WinRM** : n'autoriser les connexions que depuis les postes d'admin (pare-feu, IPsec).
2. **Respect du tiering** : pas de remoting descendant d'un compte T0 vers T1/T2.
3. **JEA** pour déléguer sans admin complet.
4. **Éviter CredSSP** ; préférer la délégation Kerberos contrainte / resource-based.
5. **HTTPS (5986)** pour le remoting hors segments de confiance ; **Protected Users** pour les comptes sensibles.

## Détection
| Événement | Source | ID |
|---|---|---|
| Connexion WinRM | Security | 4624 (LogonType 3, process wsmprovhost) |
| Création wsmprovhost.exe | Sysmon | 1 |
| Activité WinRM | Microsoft-Windows-WinRM/Operational | — |

### Règle Sigma — exécution distante via WinRM (wsmprovhost enfante un process)
```yaml
title: Exécution via WinRM (wsmprovhost process parent)
logsource:
  product: windows
  category: process_creation
detection:
  selection:
    ParentImage|endswith: '\wsmprovhost.exe'
  condition: selection
level: medium
tags:
  - attack.lateral_movement
  - attack.t1021.006
```

## Preuve de détection (purple team)
Lance un `Invoke-Command` vers une cible et vérifie le 4624 (wsmprovhost) + un process enfant qui
déclenche la règle (P7). NetExec/evil-winrm en lab pour le cas offensif.

## Rejouer contre CORP durci
Avec WinRM segmenté + JEA + tiering, un credential T2 volé n'ouvre pas de remoting vers le Tier 0/1.
