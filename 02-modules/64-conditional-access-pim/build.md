# Build — Durcir le tenant avec CA & PIM (lab)

## Pré-requis
- Tenant avec **Entra ID P2** (essai). Compte Global Admin + **comptes break-glass** créés d'abord.

## Étape 0 — Comptes break-glass (AVANT toute CA)
Créer 2 comptes d'urgence cloud-only, mots de passe très longs (coffre), **exclus** de toutes les CA,
surveillés par alerte. (Sinon risque de se verrouiller dehors.)

## Étape 1 — Politiques CA de base
- **Bloquer l'authentification héritée** (legacy auth) — priorité n°1.
- **MFA pour les administrateurs** (tous rôles à privilèges).
- **MFA pour tous les utilisateurs** (ou piloté par le risque).
- **Exiger un appareil conforme/HAADJ** pour l'accès à M365.
- (si dispo) **Token protection** pour les sessions sensibles.
Toujours commencer en mode **report-only** pour mesurer l'impact avant d'appliquer.

## Étape 2 — Vérifier via Graph
```powershell
Get-MgIdentityConditionalAccessPolicy | Select DisplayName, State
```

## Étape 3 — PIM : rendre les rôles éligibles
- Convertir les affectations **permanentes** des rôles sensibles (Global Admin, etc.) en **éligibles**.
- Exiger **MFA + justification + approbation** à l'activation ; durée courte ; alertes.

## Étape 4 — Access reviews
Configurer une revue périodique des rôles à privilèges et des accès invités.

## Étape 5 — Tester
- Tenter une connexion legacy → bloquée. Activer un rôle via PIM → MFA/justification demandés.
- Vérifier que les break-glass fonctionnent (test contrôlé) et sont alertés.

## Vérification
```powershell
Get-MgIdentityConditionalAccessPolicy | ? State -eq 'enabled' | Select DisplayName
# PIM : rôles sensibles en "eligible", plus en "permanent"
```

## Pièges courants
- Appliquer une CA **sans break-glass** → verrouillage total.
- Oublier de bloquer la **legacy auth** (contourne le MFA).
- Laisser des rôles permanents « juste au cas où » (contredit PIM).
