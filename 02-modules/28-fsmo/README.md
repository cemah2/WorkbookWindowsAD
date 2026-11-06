# Module 28 — Rôles FSMO (Phase 2)
Les 5 rôles à maître unique : comprendre, transférer, récupérer.
## Contenu
fiche (5 rôles, portées, PDC/temps, transfert vs saisie) · drills (cartographier, transfert A/R,
temps PDC, saisie simulée, break-fix RID) · build (localiser, transférer, saisir, vérifier) ·
automate (`Get-FsmoRoles.ps1`, `Move-FsmoRoles.ps1`) · attack/defend (PDC comme levier →
placement + surveillance changement FSMO).
## Definition of Done
- [ ] 5 rôles localisés ; transfert propre réalisé et vérifié
- [ ] Temps PDC vérifié ; procédure de saisie + metadata cleanup comprise
- [ ] `Get-FsmoRoles.ps1`/`Move-FsmoRoles.ps1` rejoués · drills faits (dont break-fix RID)
- [ ] ≥ 1 règle Sigma (fSMORoleOwner) · prérequis : modules 13, 26. Suite : `29-sauvegarde-pra`.
