# Drills — Kerberoasting / AS-REP

## Drill 1 — Roaster un SPN (10 min)
- **Étapes** : `GetUserSPNs -request`, observe le hash `$krb5tgs$`.
- **Observer** : l'etype (23 = RC4, plus facile).
- **Pourquoi** : comprendre ce qui est chiffré.

## Drill 2 — Casser (10 min)
- **Étapes** : `hashcat -m 13100` avec un wordlist.
- **Observer** : mot de passe faible cassé rapidement.
- **Pourquoi** : lien mot de passe faible → compromission.

## Drill 3 — AS-REP (10 min)
- **Étapes** : `GetNPUsers -no-pass` sur un compte no-preauth, casse avec `-m 18200`.
- **Pourquoi** : attaque sans aucun credential de départ.

## Drill 4 — RC4 vs AES (10 min)
- **Étapes** : force AES sur un compte de service, re-roaste, compare la difficulté/mode hashcat.
- **Pourquoi** : mesurer l'effet du durcissement.

## Drill break-fix — Roasting ne renvoie rien (10 min)
- **Casse** : cible un compte sans SPN / horloge décalée.
- **Diagnostique** : pas de ticket / erreur KRB_AP_ERR_SKEW.
- **Répare** : cible un vrai SPN, synchronise l'heure, relance.
