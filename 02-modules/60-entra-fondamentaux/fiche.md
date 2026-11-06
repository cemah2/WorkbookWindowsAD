# Fiche — Microsoft Entra ID : fondamentaux

> Volet académique. Entra ID (ex-Azure AD) est l'annuaire d'identité **cloud** de Microsoft. Il ne
> fonctionne PAS comme AD DS on-prem : comprendre les différences est la clé de l'hybride (et de ses attaques).

## 1. Rôle & utilité
Entra ID gère l'identité et l'accès pour Microsoft 365, Azure et des milliers d'applications SaaS.
Dans CORP, il étend l'identité on-prem vers le cloud (hybride) — nouvelle surface à administrer ET à défendre.

## 2. Entra ID ≠ AD DS (différences fondamentales)
| AD DS (on-prem) | Entra ID (cloud) |
|---|---|
| Kerberos / NTLM, LDAP | OAuth2 / OIDC / SAML, Microsoft Graph |
| OU, GPO | Groupes, Administrative Units, politiques (CA/Intune) |
| Forêt/domaine | Tenant |
| Contrôleurs de domaine | Service multi-tenant géré par Microsoft |
| Pas de notion native MFA | MFA/Conditional Access au cœur |

Il n'y a **pas de LDAP/Kerberos classiques** dans Entra : l'accès passe par des **tokens** OAuth2.

## 3. Concepts clés
- **Tenant** : l'instance Entra d'une organisation.
- **Identités** : utilisateurs (cloud-only / synchronisés), **service principals** & **app
  registrations** (identités d'applications), **managed identities** (Azure).
- **Rôles** : rôles Entra (ex. Global Administrator, Privileged Role Administrator…) ≠ rôles Azure RBAC.
- **Tokens** : **access token**, **refresh token**, **ID token**, et le **PRT** (Primary Refresh
  Token) pour les appareils joints.
- **Consent / OAuth** : les applications demandent des **permissions** (delegated / application) —
  surface d'abus (illicit consent grant).
- **Appareils** : Azure AD joined, Hybrid joined, registered.

## 4. Modèles d'authentification hybride (aperçu, module 61)
- **PHS** (Password Hash Sync), **PTA** (Pass-Through Authentication), **Federation (ADFS)**.

## 5. Administration
- **Portail Entra / Azure**, **Microsoft Graph** (API + `Microsoft.Graph` PowerShell), Azure CLI.
- RBAC Entra (rôles d'annuaire) + **PIM** (élévation juste-à-temps, module 64).

## 6. Rôles à privilèges critiques (Tier 0 cloud)
- **Global Administrator**, **Privileged Role Administrator**, **Application Administrator**,
  **Cloud Application Administrator**, **Privileged Authentication Administrator**… → cibles majeures.

## 7. Surface d'attaque (aperçu, module 63)
- Abus de **consent OAuth** (illicit grant), **service principals** à droits élevés, vol de **tokens/
  PRT**, **device code phishing**, rôles mal attribués, absence de MFA/CA.

## 8. Détection (aperçu)
**Entra sign-in logs**, **audit logs**, **Microsoft Graph Activity**, Identity Protection (risques).
Voir `defend.md` et module 63.

## 9. Coût & lab
- **Tenant persistant** requis pour l'hybride (vs sandbox ACG jetable). Azure free + essai Entra P2
  (90 j) pour les fonctions premium (CA/PIM/Identity Protection). Voir le point infra de la discussion.

## 10. Pour aller plus loin
Microsoft Learn — Entra ; dirkjanm.io, AADInternals. Voir `99-ressources/bibliographie.md` (P6).
