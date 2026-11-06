# Drills — Entra Connect

## Drill 1 — Forcer une synchro (10 min)
- **Étapes** : `Start-ADSyncSyncCycle -PolicyType Delta`, vérifie côté cloud.
- **Pourquoi** : comprendre le cycle de synchro.

## Drill 2 — PHS vs PTA vs Federation (10 min)
- **Étapes** : identifie la méthode active (`Get-MgDirectoryOnPremiseSynchronization` / portail).
- **Pourquoi** : chaque méthode a une surface d'attaque différente.

## Drill 3 — Filtrage d'OU (10 min)
- **Étapes** : vérifie que `OU=Admin` (Tier 0) n'est PAS synchronisée.
- **Pourquoi** : ne pas exposer le Tier 0 on-prem au cloud.

## Drill 4 — Comptes de synchro (10 min)
- **Étapes** : repère le compte `MSOL_*` on-prem et ses droits ; le compte de synchro cloud.
- **Pourquoi** : ce sont des cibles majeures (module 63).

## Drill break-fix — Synchro en échec (10 min)
- **Casse** : UPN non routable / doublon.
- **Diagnostique** : erreurs de synchro (connector run), IdFix.
- **Répare** : corrige l'UPN, relance la synchro.
