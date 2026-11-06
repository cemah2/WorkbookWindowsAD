# Solution GOAD — Extension hybride (Entra Connect) : pivot on-prem ↔ cloud

> Amélioration majeure proposée à GOAD (PROJECT.md §10) : GOAD est purement on-prem. Ajouter une
> **extension hybride** (un tenant Entra de test + Entra Connect) ouvre tout le volet cloud. Write-up
> de mise en place + chemin d'attaque + remédiation. Tenant de TEST + lab isolé uniquement.

## 1. Pourquoi cette extension
GOAD n'a aucun composant cloud : il manque donc les attaques hybrides (parmi les plus actuelles).
Relier un domaine GOAD (ou CORP) à un tenant Entra de test via Entra Connect permet de pratiquer :
Pass-the-PRT, Golden SAML, abus de service principals, pivots Connect, consent grants.

## 2. Mise en place (résumé)
1. Tenant Entra **de test** (Azure free + essai P2) — jamais un tenant de prod.
2. VM `AADC` (Tier 0) jointe au domaine ; installer **Entra Connect** en **PHS** (module 61).
3. Filtrer les OU (ne pas synchroniser le Tier 0 on-prem).
4. (Option) activer Seamless SSO (AZUREADSSOACC$) et/ou HAADJ pour un poste (module 62).

## 3. Chemin d'attaque hybride (exemple)
```
Compromission on-prem (GOAD, phases 5)             Compromission cloud
        │                                                   ▲
        ▼                                                   │
 Serveur Entra Connect (Tier 0)  ──Get-AADIntSyncCredentials──►  compte de synchro cloud
        │                                                   │
        ├─ AZUREADSSOACC$ ──► Silver Ticket cloud ──────────┤
        └─ MSOL_ (DCSync-like) ──► secrets on-prem          │
 Poste HAADJ ── Pass-the-PRT ──► tokens Graph/M365 ─────────┘
```
Étapes types :
1. Obtenir un accès admin local au serveur **Entra Connect** (via le chemin on-prem des phases 5).
2. `Import-Module AADInternals ; Get-AADIntSyncCredentials` → creds de synchro (cloud + MSOL_).
3. Utiliser le compte de synchro cloud (souvent très privilégié) pour agir dans Entra ; et MSOL_ pour
   un DCSync on-prem.
4. Alternative : extraire **AZUREADSSOACC$** → ticket cloud ; ou **Pass-the-PRT** depuis un poste HAADJ.

## 4. Impact
Franchissement bidirectionnel : un compromis on-prem livre le cloud (et réciproquement) → contrôle
des données M365/Azure et persistance cloud (service principals, rôles).

## 5. Détection
| Étape | Signal | Source |
|---|---|---|
| Accès au serveur Connect | logon admin inhabituel | Security 4624 |
| Extraction creds de synchro | lecture config ADSync | EDR / accès fichiers |
| DCSync via MSOL_ | réplication | Security 4662 |
| Usage du compte de synchro cloud | actions annuaire | Entra Audit logs |
| Pass-the-PRT / token | sign-in depuis nouvel appareil | Entra Sign-in / Identity Protection |

## 6. Remédiation
1. **Entra Connect = Tier 0** (isolation, PAW, pas d'autres rôles).
2. **PHS** (moins de surface que PTA/ADFS) ; si ADFS, protéger la clé (HSM).
3. **Roter AZUREADSSOACC$** ; restreindre/surveiller MSOL_.
4. **Ne pas synchroniser le Tier 0 on-prem** ; **comptes séparés** on-prem/cloud (pas de pont de privilège).
5. **CA + PIM + token protection** (module 64) ; MFA phishing-resistant.

## 7. Validation (boucle purple team)
Après remédiation : re-tenter le pivot → extraction de creds détectée/limitée, Silver Ticket cloud
cassé par rotation AZUREADSSOACC$, Pass-the-PRT bloqué par TPM + CA. Vérifier les logs Entra.

## 8. Pour aller plus loin
dirkjanm.io, AADInternals (o365blog), SpecterOps (cloud). Modules : `61-entra-connect`,
`62-hybrid-join-sso`, `63-attaques-hybrides`, `64-conditional-access-pim`.
