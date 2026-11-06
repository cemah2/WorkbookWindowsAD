# Attack — Évasion ETW/AMSI (compréhension défensive)

> ⚠️ Lab isolé. On décrit les mécanismes pour les détecter ; pas de code de bypass fourni.

## Techniques
- **MITRE ATT&CK** : T1562.001 (Disable/Modify Tools), T1562.006 (Indicator Blocking),
  T1055 (injection pour patcher), T1027 (obfuscation).
- **ETW patch** : neutraliser `EtwEventWrite` en mémoire → events absents pour ce process.
- **AMSI bypass** : patcher `AmsiScanBuffer`/forcer `amsiInitFailed` → contenu non scanné.
- **Unhooking** : restaurer un ntdll « propre » pour retirer les hooks EDR.
- **Provider/session tampering** : stopper des sessions ETW (logman), désactiver des providers.

## Pourquoi ça marche (et ses limites)
- L'ETW **user-mode** et les hooks user-mode sont dans l'espace du process → modifiables par lui.
- **ETW-TI (kernel)** et les capteurs kernel de l'EDR sont bien plus difficiles à contourner.

## Ancrage réel
L'évasion AMSI/ETW est quasi systématique dans les frameworks offensifs modernes (cf. *Evading EDR*).
D'où la nécessité de capteurs kernel + détection par l'absence/l'incohérence.

## Résultat attendu
Savoir **détecter** le contournement (absence d'events, modifications mémoire, chaînes de bypass) —
objet de `defend.md`.
