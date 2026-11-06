# Drills — RODC

## Drill 1 — Qui est en cache ? (10 min)
- **Étapes** : `Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity LYO-RODC-01 -RevealedAccounts`.
- **Observer** : liste des secrets réellement mis en cache.
- **Pourquoi** : mesurer l'exposition réelle en cas de vol du RODC.

## Drill 2 — PRP Allowed/Denied (10 min)
- **Étapes** : ajoute/retire un compte d'Allowed, force une authentification, re-vérifie le cache.
- **Pourquoi** : comprendre le contrôle de mise en cache.

## Drill 3 — Compte sensible jamais en cache (10 min)
- **Étapes** : tente d'authentifier un compte Tier 0 via le RODC ; vérifie qu'il n'est PAS mis en cache.
- **Pourquoi** : valider la protection des comptes sensibles.

## Drill break-fix — RODC sans localité (10 min)
- **Casse** : place le RODC dans le mauvais site (ou subnet Lyon manquant).
- **Diagnostique** : les clients Lyon s'authentifient à Paris ; `nltest /dsgetdc`.
- **Répare** : corrige site/subnet, re-teste.
