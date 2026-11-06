# Defend — Couper les pivots hybrides

## Durcissement
1. **Pas de pont de privilège** : comptes séparés on-prem (Tier 0) et cloud (Global Admin) — jamais le
   même compte pour les deux.
2. **Entra Connect & ADFS = Tier 0** (modules 61) ; préférer PHS ; protéger la clé ADFS (HSM) ; roter
   AZUREADSSOACC$.
3. **Gouvernance des apps** : désactiver le **consent utilisateur** (ou admin consent workflow),
   auditer les permissions Graph des SP, surveiller l'ajout de secrets/certs d'apps.
4. **Conditional Access** (module 64) : MFA, appareil conforme, token protection, bloquer device code.
5. **PIM** pour les rôles cloud sensibles ; **Identity Protection** (P2).
6. Ne pas synchroniser le Tier 0 on-prem ; limiter Intune aux admins dédiés.

## Détection
| Source | Signal |
|---|---|
| Entra Audit logs | ajout de rôle privilégié, consent grant, nouveau secret/cert d'app |
| Entra Sign-in logs | token/PRT depuis nouvel appareil, device code, MFA fatigue |
| Graph activity | appels Graph anormaux par un SP |
| On-prem Security | DCSync/activité MSOL_ (module 61), Golden SAML (ADFS logs) |

### Règle (conceptuelle, KQL) — ajout d'un secret à un service principal
```kusto
AuditLogs
| where OperationName has_any ("Add service principal credentials","Update application – Certificates and secrets management")
| project TimeGenerated, InitiatedBy, TargetResources
```

## Preuve de détection (purple team)
Rejoue un consent grant, un ajout de secret d'app, et un Pass-the-PRT (tenant de test) ; vérifie les
audit/sign-in logs + Identity Protection, puis applique CA/PIM et re-teste.

## Rejouer contre CORP durci
Comptes séparés + CA + PIM + consent restreint + Connect/ADFS en Tier 0 : les pivots hybrides sont
fortement limités et tracés.
