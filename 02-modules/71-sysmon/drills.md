# Drills — Sysmon

## Drill 1 — Installer + lire (10 min)
- **Étapes** : `sysmon -i config.xml`, génère un process, lis le Sysmon 1 (ligne de commande).
- **Pourquoi** : voir la richesse vs log natif.

## Drill 2 — Accès LSASS (Sysmon 10) (10 min)
- **Étapes** : déclenche un accès à lsass.exe (outil de lab), repère le Sysmon 10 + GrantedAccess.
- **Pourquoi** : la détection de dump de creds (module 56).

## Drill 3 — PowerShell encodé (Sysmon 1) (10 min)
- **Étapes** : lance une commande encodée bénigne, repère-la dans Sysmon 1.
- **Pourquoi** : lien avec module 30.

## Drill 4 — Comparer deux configs (10 min)
- **Étapes** : applique SwiftOnSecurity puis Olaf Hartong, compare le volume/les champs.
- **Pourquoi** : la config fait toute la différence.

## Drill break-fix — Sysmon muet (10 min)
- **Casse** : arrête le service Sysmon.
- **Diagnostique** : plus d'événements ; état du service.
- **Répare** : relance, et ajoute une alerte sur l'arrêt (defend).
