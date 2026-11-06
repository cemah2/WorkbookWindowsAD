# Drills — Entra fondamentaux

## Drill 1 — Graph : explorer (10 min)
- **Étapes** : `Connect-MgGraph`, `Get-MgUser`, `Get-MgDirectoryRole`.
- **Pourquoi** : l'API Graph est la porte d'entrée (admin ET attaquant).

## Drill 2 — Rôles Entra vs Azure RBAC (10 min)
- **Étapes** : compare `Get-MgDirectoryRole` (Entra) et `az role assignment list` (Azure).
- **Observer** : deux systèmes de permissions distincts.
- **Pourquoi** : éviter une confusion fréquente.

## Drill 3 — App registration & service principal (15 min)
- **Étapes** : crée une app registration, observe le service principal associé et ses permissions.
- **Pourquoi** : base pour comprendre les abus d'applications (module 63).

## Drill 4 — Lire les sign-in logs (10 min)
- **Étapes** : `Get-MgAuditLogSignIn`, identifie app, statut, localisation.
- **Pourquoi** : la détection cloud repose sur ces logs.
