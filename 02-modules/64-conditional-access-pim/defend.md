# Defend — CA/PIM robustes

## Durcissement
1. **Bloquer la legacy auth** (CA dédiée).
2. **MFA** partout, **résistante au phishing** si possible (FIDO2/Windows Hello) → limite la MFA fatigue.
3. **Appareil conforme/HAADJ** + **token protection** pour les accès sensibles.
4. **PIM** : zéro rôle à privilèges permanent (tout en éligible, MFA+approbation), **access reviews**.
5. **Minimiser les exclusions** CA ; **break-glass** uniquement, surveillés.
6. **Identity Protection** : politiques basées sur le risque utilisateur/connexion.

## Détection
| Source | Signal |
|---|---|
| Entra Audit logs | modif de politique CA, affectation de rôle, activation PIM |
| Entra Sign-in logs | legacy auth, MFA fatigue (multiples prompts), connexions à risque |
| PIM logs | activations de rôle (hors fenêtre, sans justification) |
| Break-glass | toute connexion = alerte |

### Règle (conceptuelle, KQL) — usage d'un compte break-glass
```kusto
SigninLogs
| where UserPrincipalName in ("breakglass1@tenant.onmicrosoft.com","breakglass2@...")
| project TimeGenerated, UserPrincipalName, AppDisplayName, IPAddress, ResultType
```

## Preuve de détection (purple team)
Tente une connexion legacy / une MFA fatigue (tenant de test) et vérifie les sign-in logs + le blocage
CA ; active un rôle via PIM et vérifie l'audit ; connecte un break-glass et vérifie l'alerte.

## Rejouer contre CORP durci
Legacy bloquée + MFA phishing-resistant + PIM sans permanent + token protection : le spray, la MFA
fatigue et le token theft deviennent très difficiles et tracés.
