# Build — Déployer Entra Connect (PHS) dans CORP

> On relie `corp.meridian.com` au tenant Entra via Entra Connect en **PHS** (recommandé). Serveur
> dédié `PAR-AADC-01` (Tier 0, voir architecture.md).

## Pré-requis
- Tenant Entra persistant + Global Admin. VM `PAR-AADC-01` jointe au domaine (Tier 0).
- Un domaine public vérifié dans Entra idéalement (sinon .onmicrosoft.com + UPN routable).

## Étape 1 — Préparer
- Vérifier les UPN on-prem (routables), nettoyer les doublons (IdFix).
- Décider le périmètre de synchro (OU filtrées — ne pas synchroniser le Tier 0 on-prem !).

## Étape 2 — Installer Entra Connect
- Télécharger Entra Connect, lancer l'assistant → **Express** (PHS) ou **Custom**.
- Choisir **Password Hash Synchronization**, activer **Seamless SSO** si voulu.
- **Filtrage OU** : exclure `OU=Admin` (Tier 0) de la synchro.

## Étape 3 — Vérifier la synchro
```powershell
# Sur le serveur Connect
Import-Module ADSync
Get-ADSyncScheduler | Select SyncCycleEnabled, NextSyncCyclePolicyType
Start-ADSyncSyncCycle -PolicyType Delta
```
Côté cloud :
```powershell
Get-MgUser -Filter "onPremisesSyncEnabled eq true" -Top 10 | Select UserPrincipalName, OnPremisesSyncEnabled
Get-MgDirectoryOnPremiseSynchronization | Select Features
```

## Étape 4 — Protéger les comptes sensibles
- Traiter `PAR-AADC-01` comme **Tier 0** (PAW, isolation).
- Protéger/roter **AZUREADSSOACC$** (si Seamless SSO) régulièrement.
- Restreindre les droits du compte `MSOL_*` (il a des droits de réplication on-prem).

## Étape 5 — Writeback (optionnel)
Activer password writeback si besoin (SSPR hybride) — bien cadrer les droits.

## Vérification
```powershell
Get-ADSyncConnectorRunStatus        # état des runs de synchro
# Un utilisateur on-prem apparaît dans Entra (onPremisesSyncEnabled = true)
```

## Pièges courants
- **Synchroniser le Tier 0 on-prem** vers le cloud (exposition) → filtrer les OU admin.
- Laisser `PAR-AADC-01` hors Tier 0 (c'est une cible critique).
- Oublier de roter AZUREADSSOACC$.
