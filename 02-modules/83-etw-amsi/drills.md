# Drills — ETW & AMSI

## Drill 1 — Sessions ETW (10 min)
- **Étapes** : `logman query -ets`, repère les sessions (EventLog, Sysmon, EDR).
- **Pourquoi** : savoir ce qui collecte quoi.

## Drill 2 — AMSI fonctionne ? (10 min)
- **Étapes** : soumets la chaîne de test AMSI ; vérifie le blocage.
- **Pourquoi** : valider la protection avant d'étudier son contournement.

## Drill 3 — Absence d'event = signal (10 min)
- **Étapes** : compare un PowerShell avec logging vs un scénario où les 4104 manqueraient.
- **Pourquoi** : détecter l'évasion par l'absence.

## Drill 4 — ETW-TI vs ETW user-mode (10 min)
- **Étapes** : comprends pourquoi ETW-TI (kernel, PPL) est plus robuste que l'ETW user-mode.
- **Pourquoi** : choisir des sources résistantes à l'évasion.

## Drill break-fix — PowerShell logging muet (10 min)
- **Casse** : désactive le Script Block Logging (GPO/registre).
- **Diagnostique** : plus de 4104 malgré de l'activité PS.
- **Répare** : réactive le logging ; comprends l'angle mort.
