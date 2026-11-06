# Module 61 — Entra Connect (Phase 6)
Le pont de synchronisation hybride — et un Tier 0 critique.
## Contenu
fiche (PHS/PTA/Federation, comptes de synchro MSOL_/AZUREADSSOACC$, matching) · drills (forcer synchro,
méthode active, filtrage OU, comptes de synchro, break-fix) · build (déployer PHS, filtrer le Tier 0,
vérifier, protéger) · automate (`Sync-Status.ps1`) · attack (Connect/ADFS comme pivot hybride) ·
defend (Connect=Tier 0 + PHS + comptes de synchro protégés + détection DCSync).
## Definition of Done
- [ ] Entra Connect (PHS) opérationnel ; users on-prem visibles dans Entra ; Tier 0 **non** synchronisé
- [ ] Serveur Connect traité en Tier 0 ; AZUREADSSOACC$/MSOL_ compris et protégés
- [ ] `Sync-Status.ps1` rejoué · drills faits (dont break-fix synchro) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 22, 60. Suite : `62-hybrid-join-sso`.
