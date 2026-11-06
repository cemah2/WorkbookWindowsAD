# Drills — Threat Hunting

## Drill 1 — Hunt Kerberoasting (15 min)
- **Étapes** : requête 4769 RC4 agrégée par compte ; identifie l'anomalie laissée par le module 52.
- **Pourquoi** : retrouver une attaque connue dans les données.

## Drill 2 — Hunt DCSync (10 min)
- **Étapes** : cherche 4662 (GUID réplication) depuis une IP non-DC.
- **Pourquoi** : détecter un vol de secrets par réplication.

## Drill 3 — Least-frequency (15 min)
- **Étapes** : stack les process (Sysmon 1) par rareté ; examine les plus rares.
- **Pourquoi** : la rareté révèle souvent l'attaquant.

## Drill 4 — BloodHound défensif (15 min)
- **Étapes** : cherche les chemins récents vers le Tier 0 / edges dangereux.
- **Pourquoi** : chasser les escalades latentes.

## Drill break-fix — Hunt stérile faute de logs (10 min)
- **Casse** : audit/Sysmon partiel.
- **Diagnostique** : la requête ne renvoie rien (pas de données).
- **Répare** : compléter la collecte (modules 70-71), rejouer.
