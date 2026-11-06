# Drills — Attaques hybrides

## Drill 1 — Cartographier les ponts (10 min)
- **Étapes** : lister Connect, AZUREADSSOACC$, ADFS (si présent), apps à droits Graph élevés.
- **Pourquoi** : identifier les pivots avant tout.

## Drill 2 — Consent grant (15 min)
- **Étapes** : crée une app, simule un consent, utilise le token (tenant de test).
- **Observer** : accès aux données via OAuth sans mot de passe.
- **Pourquoi** : l'abus de consent est très courant.

## Drill 3 — Pass-the-PRT (15 min)
- **Étapes** : sur un poste HAADJ sans TPM (lab), extrais le PRT, obtiens un token Graph.
- **Pourquoi** : comprendre le vol de session cloud.

## Drill 4 — Comptes à pont de privilège (10 min)
- **Étapes** : repère un compte qui serait admin on-prem ET Global Admin cloud.
- **Pourquoi** : c'est l'anti-pattern à éliminer.

## Drill break-fix — CA bloque le pivot (10 min)
- **Casse/Répare** : active une CA exigeant appareil conforme ; re-tente un pivot token → bloqué.
- **Pourquoi** : voir l'effet du durcissement (module 64).
