# Drills — Premier DC

> Exercices courts autour de la promotion. Certains se font sur une VM jetable (snapshot avant),
> car promouvoir/rétrograder est l'apprentissage lui-même.

## Drill 1 — Lire les SRV d'un domaine (10 min)
- **Objectif** : voir comment un client "trouve" un DC.
- **Étapes** :
  ```powershell
  Resolve-DnsName -Type SRV _ldap._tcp.dc._msdcs.corp.meridian.com
  Resolve-DnsName -Type SRV _kerberos._tcp.corp.meridian.com
  ```
- **Observer** : les enregistrements pointent vers `PAR-DC-01`. C'est la localisation de DC.
- **Pourquoi** : sans ces SRV (DNS cassé), aucun client ne s'authentifie.

## Drill 2 — Explorer les partitions (10 min)
- **Objectif** : comprendre Schema / Configuration / Domain.
- **Étapes** : ouvre **ADSI Edit**, connecte-toi successivement aux 3 partitions ; repère
  `krbtgt` dans la partition de domaine (conteneur Users).
- **Observer** : l'annuaire est structuré en partitions répliquées différemment.
- **Pourquoi** : base pour la réplication (module 26) et les attaques (DCSync).

## Drill 3 — dcdiag, lecture d'un bilan de santé (10 min)
- **Objectif** : savoir lire l'outil de diagnostic n°1.
- **Étapes** : `dcdiag /v` ; identifie les tests `Connectivity`, `Advertising`, `DNS`.
- **Observer** : ce qu'est un DC "sain".
- **Pourquoi** : tu reliras dcdiag à chaque incident.

## Drill 4 — Promotion automatisée sur VM jetable (15 min)
- **Objectif** : vivre la bascule manuel → code.
- **Étapes** : sur une VM jetable, exécute `automate/New-FirstDC.ps1` (voir dossier automate).
- **Observer** : le même résultat qu'en GUI, en une commande.
- **Pourquoi** : préfigure l'IaC de la Phase 3.

## Drill break-fix — SRV manquants / DNS client erroné (10 min)
- **Casse** : repointe le DNS client du DC vers `10.10.0.1` (et non lui-même) après promotion.
- **Diagnostique** : `dcdiag /test:DNS` → erreurs ; `Resolve-DnsName` des SRV échoue.
- **Répare** : `Set-DnsClientServerAddress ... 127.0.0.1`, `ipconfig /registerdns`, `dcdiag` repart au vert.
