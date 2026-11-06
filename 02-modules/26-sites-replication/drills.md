# Drills — Sites & réplication

## Drill 1 — Lire la santé de réplication (10 min)
- **Étapes** : `repadmin /replsummary` puis `repadmin /showrepl`.
- **Observer** : partenaires, dernière réussite, erreurs éventuelles.
- **Pourquoi** : c'est le réflexe de diagnostic n°1 en multi-DC.

## Drill 2 — Propagation d'un changement (10 min)
- **Étapes** : crée un user sur PAR-DC-01, mesure le temps avant qu'il apparaisse sur NYC-DC-01
  (selon l'intervalle du site link), force avec `repadmin /syncall`.
- **Pourquoi** : comprendre intra vs inter-site.

## Drill 3 — Localisation de DC par site (10 min)
- **Étapes** : `nltest /dsgetdc:corp.meridian.com` depuis des clients de sites différents.
- **Observer** : chaque client trouve un DC de son site.

## Drill 4 — Coût de site link (10 min)
- **Étapes** : modifie le coût d'un site link, observe l'effet sur les chemins (repadmin).
- **Pourquoi** : piloter la topologie.

## Drill break-fix — Subnet manquant (10 min)
- **Casse** : retire le subnet d'un site.
- **Diagnostique** : les clients de ce subnet s'authentifient sur un DC distant ; log Netlogon
  "no site" ; `nltest /dsgetdc` montre un DC hors site.
- **Répare** : recrée le subnet, re-teste.
