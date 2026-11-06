# Attack — Évasion & désactivation d'EDR (compréhension défensive)

> ⚠️ Lab isolé. Synthèse des modules 80-83 ; aucune fourniture d'outil d'évasion. But : connaître les
> angles morts pour les couvrir.

## Techniques
- **MITRE ATT&CK** : T1562.001 (Disable/Modify Tools), T1211 (Exploitation for Defense Evasion),
  T1068 (BYOVD), T1055 (injection), T1027 (obfuscation), T1070.
- **Familles** :
  - **Unhooking / syscalls directs** : contourner les hooks user-mode.
  - **ETW/AMSI patch** (module 83).
  - **BYOVD** : driver vulnérable → tuer/aveugler l'EDR depuis le kernel.
  - **Tampering** : stopper/désinstaller l'agent (si tamper protection off).
  - **LOLBins** : se fondre dans le légitime.

## Pourquoi certaines marchent
- Les capteurs **user-mode** sont dans l'espace du process → modifiables. Les capteurs **kernel/ETW-TI**
  et la détection **comportementale/cloud** sont bien plus robustes.

## Ancrage réel
*Evading EDR* détaille ces techniques ; les groupes avancés et certains rançongiciels désactivent l'EDR
(BYOVD) avant l'impact. D'où tamper protection + capteurs kernel + détection de la désactivation.

## Résultat attendu
Une liste d'angles morts par technique → couverts par la stratégie multi-couches (`defend.md`).
