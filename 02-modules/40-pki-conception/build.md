# Build — Concevoir la PKI de CORP (document de conception)

> Ce module produit surtout une **conception** (choix documentés) + la préparation. Le déploiement
> concret est au module 41. L'objectif : des décisions explicites avant toute installation.

## Pré-requis
- CORP opérationnel (phases 1-2). Prévoir 2 VM : `ROOT-CA` (hors-ligne) et `PAR-CA-01` (Issuing).

## Étape 1 — Décider la hiérarchie (CORP)
- **Root CA** : standalone, **hors-ligne**, RSA 4096 / SHA-256, validité 15 ans. Émet uniquement le
  certificat de l'Issuing CA.
- **Issuing CA** : Enterprise Subordinate, en ligne (`PAR-CA-01`, Tier 0, VLAN 99), validité 5 ans,
  certificats feuilles ≤ 1-2 ans.

## Étape 2 — Définir les usages
Lister ce que la PKI servira : authentification par certificat (smartcard/PKINIT), TLS interne
(LDAPS !, serveurs web internes), Wi-Fi/802.1X, VPN, signature de code interne. Chaque usage = un
**template** (module 42).

## Étape 3 — Révocation & publication
- **CDP/AIA** publiés en **HTTP** (accessible même root hors-ligne) — ex. `http://pki.corp.meridian.com/`.
- **CRL** : intervalle de publication + delta CRL ; **OCSP** optionnel pour le temps réel.

## Étape 4 — CAPolicy.inf (préparer)
Rédiger `C:\Windows\CAPolicy.inf` pour chaque CA (contraintes de durée, CPS, pas d'auto-renew de la
root, etc.). Exemple fourni dans `automate/`.

## Étape 5 — Séparation des rôles & protection des clés
- CA = **Tier 0** ; administration depuis PAW.
- Rôles AD CS séparés (CA Admin vs Certificate Manager) ; en prod, **HSM** pour les clés.

## Étape 6 — Formaliser
Rédige un court **document de conception** (hiérarchie, durées, usages, révocation, templates prévus,
sécurité). C'est le livrable de ce module (versionné dans le dépôt).

## Vérification
- Le document répond à : quelle hiérarchie ? quels usages/templates ? quelle révocation ? comment les
  clés et l'administration sont protégées ? → prêt pour le déploiement (module 41).

## Pièges courants
- Root CA en ligne / Enterprise (mauvaise pratique : garder la root hors-ligne et standalone).
- CDP/AIA inaccessibles → validation de chaîne qui échoue.
- Oublier que la PKI est Tier 0.
