# Drills — Trusts cross-forest

## Drill 1 — Cartographier les trusts (10 min)
- **Étapes** : `Get-ADTrust` / PowerView Get-DomainTrust.
- **Observer** : direction, type, transitivité, SID filtering.
- **Pourquoi** : comprendre la topologie de confiance.

## Drill 2 — Vérifier le SID filtering (10 min)
- **Étapes** : `netdom trust ... /quarantine`.
- **Observer** : actif/inactif.
- **Pourquoi** : c'est LA protection cross-forest.

## Drill 3 — SID history (si filtering off, lab) (15 min)
- **Étapes** : forger un ticket inter-realm avec extra-sid privilégié.
- **Pourquoi** : comprendre l'escalade cross-forest.

## Drill 4 — Durcir et re-tester (10 min)
- **Étapes** : active le SID filtering, rejoue l'attaque → échec.
- **Pourquoi** : boucle attaque → remédiation → validation.

## Drill break-fix — Pivot M&A (10 min)
- **Casse** : trust bidirectionnel large, Nimbus (faible) compromis.
- **Diagnostique** : chemin vers CORP via le trust.
- **Répare** : Selective Authentication + SID filtering + réduire la direction.
