# Drills — Windows Internals

## Drill 1 — Arbre de process (10 min)
- **Étapes** : dans Process Explorer, trouve un process et remonte son lineage.
- **Pourquoi** : le parentage est clé pour la détection (ex. Office→PowerShell).

## Drill 2 — Handles vers LSASS (10 min)
- **Étapes** : observe les handles ouverts sur lsass.exe.
- **Pourquoi** : comprendre ce qu'un dump de creds manipule (Sysmon 10).

## Drill 3 — DLL d'un process (10 min)
- **Étapes** : liste les DLL chargées d'un process ; repère une DLL hors system32 (indice sideloading).
- **Pourquoi** : détection d'injection/sideloading (Sysmon 7).

## Drill 4 — Autoruns (10 min)
- **Étapes** : inventorie les points de démarrage automatique.
- **Pourquoi** : cartographier la surface de persistance.

## Drill 5 — Syscalls (observation) (10 min)
- **Étapes** : avec Procmon, observe les opérations d'un simple `notepad` (CreateFile, RegOpenKey…).
- **Pourquoi** : relier action haut niveau et opérations système.
