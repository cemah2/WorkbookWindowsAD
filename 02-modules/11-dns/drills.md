# Drills — DNS

> Exercices courts. Un DC avec DNS (module 13) suffit.

## Drill 1 — Anatomie d'une résolution (10 min)
- **Objectif** : voir chaque étape nom → IP.
- **Étapes** : `Resolve-DnsName par-dc-01.corp.meridian.com` puis un `nslookup` interactif
  (changer de serveur, interroger un SRV).
- **Observer** : la réponse, le serveur qui répond, le type d'enregistrement.
- **Pourquoi** : savoir lire une résolution = diagnostiquer 50 % des pannes AD.

## Drill 2 — Créer et résoudre un enregistrement (10 min)
- **Étapes** : crée un `A` `app01.corp.meridian.com → 10.10.0.50`, puis un `CNAME`
  `intranet → app01`. Résous les deux.
- **Observer** : CNAME qui pointe vers A.
- **Pourquoi** : base de la publication de services internes.

## Drill 3 — Transfert de zone : autorisé ou non ? (10 min)
- **Objectif** : comprendre la fuite AXFR.
- **Étapes** (depuis le poste attaquant) : `dig AXFR corp.meridian.com @10.10.0.10`.
- **Observer** : par défaut refusé (bien) ; si tu l'autorises temporairement, toute la zone sort.
- **Pourquoi** : c'est une divulgation classique — à bloquer (voir defend.md).

## Drill 4 — SRV et localisation de site (10 min)
- **Étapes** : `Resolve-DnsName -Type SRV _ldap._tcp.dc._msdcs.corp.meridian.com` puis explore
  les SRV `_sites`.
- **Observer** : comment un client préférera un DC de son site (utile en module 26).

## Drill break-fix — Mise à jour dynamique non sécurisée (10 min)
- **Casse** : passe la zone en "Nonsecure and secure", crée un faux `A` depuis une machine non jointe.
- **Diagnostique** : repère l'enregistrement illégitime.
- **Répare** : repasse en "Secure only", supprime le faux enregistrement, re-teste.
