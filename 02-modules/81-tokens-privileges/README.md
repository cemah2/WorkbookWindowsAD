# Module 81 — Tokens & privilèges (Phase 8)
Comprendre l'identité et les privilèges d'un process (escalade locale), côté détection.
## Contenu
fiche (contenu d'un token, privilèges sensibles Se*, impersonation, integrity) · drills (whoami /all,
comparer tokens, compte de service, User Rights, break-fix privilège) · build (inspecter tokens,
privilèges sensibles, ProcExp, impersonation, GPO) · automate (`Get-PrivAudit.ps1`) · attack (Potato/
SeDebug/SeBackup/BYOVD — compréhension) · defend (moindre privilège + gMSA + détection 4672/lineage).
## Definition of Done
- [ ] Token décodé (SID/groupes/privilèges/integrity) ; privilèges sensibles identifiés
- [ ] Surface « Potato » (SeImpersonate) comprise sur un compte de service
- [ ] `Get-PrivAudit.ps1` rejoué · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 22, 80. Suite : `82-lsass-dpapi`.
