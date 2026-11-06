# Drills — EDR

## Drill 1 — Capteurs de l'EDR (10 min)
- **Étapes** : identifie si l'EDR a des capteurs kernel/ETW-TI vs user-mode.
- **Pourquoi** : la robustesse dépend de la couche.

## Drill 2 — Détection comportementale (15 min)
- **Étapes** : rejoue Office→PowerShell→LSASS (Atomic), observe la détection EDR.
- **Pourquoi** : les séquences battent les IoC.

## Drill 3 — Tamper protection (10 min)
- **Étapes** : tente d'arrêter l'agent (lab) → doit être bloqué/alerté.
- **Pourquoi** : protéger le capteur.

## Drill 4 — Recoupement multi-sources (15 min)
- **Étapes** : pour une technique, liste ce que voient EDR / Sysmon / SIEM.
- **Pourquoi** : defense-in-depth.

## Drill break-fix — EDR aveugle sur une évasion (10 min)
- **Casse/Diagnostique** : une technique d'évasion (module 83) passe sous les hooks user-mode.
- **Répare** : s'appuyer sur le capteur kernel/ETW-TI + détection par comportement/absence.
