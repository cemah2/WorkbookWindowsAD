# Drills — DFS

## Drill 1 — Localité par site (10 min)
- **Étapes** : depuis un client EMEA puis un client AMER, `Get-DfsnFolderTarget` / observe vers
  quel serveur le référral pointe.
- **Observer** : chacun est dirigé vers la cible de son site.
- **Pourquoi** : comprendre l'intérêt multi-sites de DFS-N.

## Drill 2 — Réplication en action (10 min)
- **Étapes** : crée un fichier sur un membre, surveille `Get-DfsrBacklog`, vérifie son apparition
  sur l'autre membre.
- **Pourquoi** : visualiser DFS-R + le backlog.

## Drill 3 — Conflit de réplication (10 min)
- **Étapes** : modifie le même fichier sur les deux membres quasi simultanément.
- **Observer** : "dernier écrivain gagne", le perdant va dans ConflictAndDeleted.
- **Pourquoi** : comprendre la résolution de conflits.

## Drill 4 — ACL via AGDLP (10 min)
- **Étapes** : vérifie qu'un membre de RES_FS-Finance_RW écrit, qu'un RO ne peut que lire.
- **Pourquoi** : relier DFS et la stratégie de groupes.

## Drill break-fix — Backlog qui ne se vide pas (10 min)
- **Casse** : coupe la connexion réseau entre membres, crée des fichiers.
- **Diagnostique** : `Get-DfsrBacklog` monte ; événements DFSR.
- **Répare** : rétablis le lien, observe le backlog se résorber.
