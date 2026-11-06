# Drills — Sigma

## Drill 1 — Lire/écrire une règle (10 min)
- **Étapes** : décortique `rules/kerberoasting.yml`, modifie un seuil.
- **Pourquoi** : comprendre selection/condition/tags.

## Drill 2 — Convertir (10 min)
- **Étapes** : `sigma convert -t <backend>` sur 2-3 règles.
- **Observer** : la requête générée.
- **Pourquoi** : « écrire une fois, déployer partout ».

## Drill 3 — Prouver une règle (15 min)
- **Étapes** : rejoue l'attaque correspondante (module 74), vérifie le déclenchement.
- **Pourquoi** : une règle non testée ne compte pas.

## Drill 4 — Réduire les faux positifs (10 min)
- **Étapes** : ajoute un filtre (ex. exclure comptes machines) et re-teste.
- **Pourquoi** : qualité de détection.

## Drill break-fix — Règle qui ne déclenche jamais (10 min)
- **Casse** : règle sur un EventID dont l'audit est désactivé.
- **Diagnostique** : l'event n'existe pas (auditpol).
- **Répare** : active l'audit (module 70) ou corrige la logsource.
