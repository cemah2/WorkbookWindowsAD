# Attack — Évasion de Sysmon

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Pour comprendre les limites et les compléter.

## Techniques
- **MITRE ATT&CK** : T1562.001 (Impair Defenses), T1562.006 (Indicator Blocking), T1070.
- **Exemples** : désinstaller/arrêter Sysmon, modifier sa config (exclure son propre binaire),
  **patch ETW** (évasion avancée, module 83), parent spoofing.

## Déroulé (principe)
1. Avec l'admin, tenter d'arrêter/désinstaller Sysmon ou d'altérer sa config.
2. Techniques avancées : désactiver la source ETW de Sysmon (module 83, orienté détection).

## Ancrage réel
Les opérateurs avancés neutralisent Sysmon/ETW pour échapper à la détection. D'où la nécessité de
surveiller l'intégrité de Sysmon et de compléter par un EDR.

## Résultat attendu
Comprendre que Sysmon n'est pas infaillible → surveiller son altération (`defend.md`) + EDR.
