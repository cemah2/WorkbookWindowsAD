# Defend — Hygiène de base d'un tenant Entra

## Durcissement
1. **MFA partout** + **Conditional Access** (module 64) ; bloquer l'authentification héritée.
2. **Moindre privilège** sur les rôles Entra ; **PIM** (élévation JIT) pour les rôles sensibles.
3. **Gouvernance des applications** : limiter le **consent utilisateur**, revoir les permissions Graph
   des service principals, surveiller les secrets/certs d'apps.
4. **Comptes d'urgence (break-glass)** exclus de CA, surveillés.
5. **Identity Protection** (P2) pour les risques utilisateur/connexion.

## Détection
| Source | Usage |
|---|---|
| **Entra Sign-in logs** | connexions (réussies/échouées), app, localisation, risque |
| **Audit logs** | changements d'annuaire (rôles, apps, consent) |
| **Microsoft Graph Activity logs** | appels Graph (abus d'API) |
| **Identity Protection** | détections de risque |

### Règle (conceptuelle, KQL — pas un Event ID Windows)
```kusto
// Attribution d'un rôle Entra à privilèges (audit log)
AuditLogs
| where OperationName has "Add member to role"
| where TargetResources has_any ("Global Administrator","Privileged Role Administrator")
```

## Preuve de détection (purple team)
Attribue un rôle sensible de test et vérifie l'entrée d'audit ; connecte-toi depuis un contexte
inhabituel et observe le sign-in log / Identity Protection.

## Rejouer contre CORP durci
Avec MFA/CA + PIM + consent restreint, les abus d'identité cloud sont fortement limités et tracés.
