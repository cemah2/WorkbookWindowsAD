# Drills — Sauvegarde & PRA

## Drill 1 — Recycle Bin (10 min)
- **Étapes** : supprime un user de test, restaure-le avec `Restore-ADObject`.
- **Observer** : restauration sans DSRM, attributs conservés.
- **Pourquoi** : la récupération la plus fréquente au quotidien.

## Drill 2 — Restauration autoritaire (15 min)
- **Étapes** (lab) : supprime une OU, restaure-la en autoritaire (ntdsutil), vérifie qu'elle
  "gagne" après réplication.
- **Pourquoi** : réintroduire une suppression propagée partout.

## Drill 3 — Metadata cleanup d'un DC mort (15 min)
- **Étapes** : éteins définitivement un DC lab, nettoie ses métadonnées, vérifie `repadmin`.
- **Pourquoi** : procédure réelle après perte d'un DC.

## Drill 4 — Restaurer une VM DC depuis PBS (15 min)
- **Étapes** : restaure une VM DC depuis Proxmox Backup Server dans un réseau isolé, `dcdiag`.
- **Pourquoi** : valider le PRA de bout en bout.

## Drill break-fix — "Mon seul DC a explosé" (15 min)
- **Casse** : supprime/corromps le DC principal (lab, snapshot de sécurité avant !).
- **Diagnostique** : plus d'authentification ; évalue les options (restaurer system state vs VM).
- **Répare** : restaure depuis PBS/system state, saisis les FSMO si besoin (module 28), vérifie.
