# Drills — Déploiement AD CS

## Drill 1 — Vérifier la chaîne (10 min)
- **Étapes** : `certutil -verify -urlfetch` sur un certificat émis par l'Issuing.
- **Observer** : chaîne root→issuing→feuille, révocation récupérée.
- **Pourquoi** : valider que CDP/AIA fonctionnent.

## Drill 2 — Publier une CRL de root hors-ligne (10 min)
- **Étapes** : rallume la root, `certutil -crl`, publie, re-éteins.
- **Pourquoi** : procédure récurrente d'une root hors-ligne.

## Drill 3 — Activer et lire l'audit AD CS (10 min)
- **Étapes** : `certutil -setreg CA\AuditFilter 127`, émets un cert, lis les events 4886/4887.
- **Pourquoi** : préparer la détection des ESC.

## Drill 4 — ping de la CA (5 min)
- **Étapes** : `certutil -ping -config "PAR-CA-01\Meridian Issuing CA"`.
- **Pourquoi** : réflexe de diagnostic.

## Drill break-fix — Révocation injoignable (10 min)
- **Casse** : rends le CDP HTTP inaccessible.
- **Diagnostique** : `certutil -verify` signale la révocation non vérifiable.
- **Répare** : rétablis le CDP, re-vérifie.
