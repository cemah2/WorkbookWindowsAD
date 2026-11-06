# Drills — Recon & énumération

## Drill 1 — Shortest path BloodHound (15 min)
- **Étapes** : collecte, importe, lance "Shortest paths to Domain Admins".
- **Observer** : le chemin et les edges (type d'abus).
- **Pourquoi** : penser en graphe d'attaque.

## Drill 2 — NetExec en éventail (10 min)
- **Étapes** : `--users`, `--groups`, `--pass-pol`, `--shares`.
- **Pourquoi** : panorama rapide d'un domaine.

## Drill 3 — User enum Kerberos (10 min)
- **Étapes** : `kerbrute userenum`.
- **Observer** : utilisateurs valides sans mot de passe (via réponses Kerberos).
- **Pourquoi** : énumération non authentifiée.

## Drill 4 — Repérer les attributs à risque (10 min)
- **Étapes** : requêtes LDAP pour SPN, no-preauth, RBCD, KeyCredentialLink.
- **Pourquoi** : identifier les vecteurs des modules suivants.

## Drill break-fix — Collecte BloodHound qui échoue (10 min)
- **Casse** : mauvais DNS/realm → le collector ne résout pas.
- **Diagnostique** : erreurs de résolution ; vérifie `-ns` (DC) et `/etc/resolv.conf`.
- **Répare** : pointe le DNS sur le DC, relance.
