# Drills — Groupes & AGDLP

## Drill 1 — Appartenance effective vs directe (10 min)
- **Étapes** : `Get-ADPrincipalGroupMembership jon.snow` puis déplie les imbrications.
- **Observer** : les droits viennent souvent d'imbrications, pas d'appartenances directes.

## Drill 2 — Portées par l'erreur (10 min)
- **Étapes** : tente d'ajouter un domain local dans un global → échec ; l'inverse → ok.
- **Pourquoi** : ancrer les règles d'imbrication.

## Drill 3 — AGDLP complet (15 min)
- **Étapes** : refais la chaîne A→G→DL→P sur une nouvelle ressource, teste l'accès.
- **Pourquoi** : automatiser le geste standard d'octroi d'accès.

## Drill 4 — Nested groups & BloodHound (10 min)
- **Étapes** : imbrique un groupe dans un groupe à privilèges, observe le chemin dans BloodHound.
- **Pourquoi** : comprendre l'escalade par imbrication.

## Drill break-fix — Accès refusé malgré l'appartenance (10 min)
- **Casse** : ajoute jon.snow au groupe APRÈS l'ouverture de sa session.
- **Diagnostique** : le token ne contient pas encore le groupe (`whoami /groups`).
- **Répare** : déconnexion/reconnexion (nouveau TGT) ; l'accès fonctionne. Leçon : le token est
  calculé à l'ouverture de session.
