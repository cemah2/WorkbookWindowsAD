# Attack — Aveugler la détection (anti-forensics)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). On comprend comment les attaquants gênent la collecte.

## Techniques
- **MITRE ATT&CK** : T1070.001 (Clear Windows Event Logs), T1562.001 (Disable/Modify Tools),
  T1562.002 (Disable Windows Event Logging).
- **Exemples** : `wevtutil cl Security`, `Clear-EventLog`, stopper le service EventLog/Sysmon,
  désactiver des catégories d'audit, patch ETW (évasion avancée, module 83).

## Déroulé (principe)
1. Après compromission, l'attaquant efface/désactive les logs pour effacer ses traces.
2. Si la collecte n'est pas **immédiate** (forward au fil de l'eau), les preuves sont perdues.

## Ancrage réel
L'effacement des journaux et la désactivation d'ETW/Sysmon sont des étapes classiques de
post-exploitation pour échapper au SOC.

## Résultat attendu
Comprendre pourquoi le **forward immédiat** + alerte 1102 + intégrité du SIEM sont essentiels (`defend.md`).
