# Module 82 — LSASS & DPAPI (Phase 8)
Les mécanismes des secrets Windows — comprendre pour protéger/détecter.
## Contenu
fiche (LSASS/SSP/WDigest, PPL/Credential Guard, DPAPI master key & domain backup key) · drills (posture,
Sysmon 10, master keys DPAPI, effet PPL, break-fix) · build (état des protections, durcir, observer
DPAPI, valider Sysmon 10) · automate (`Get-CredProtection.ps1`, `Enable-CredProtection.ps1`) · attack
(LSASS/DPAPI compréhension) · defend (Credential Guard/PPL/WDigest + backup key Tier 0 + détection 10/11).
## Definition of Done
- [ ] Posture LSASS auditée (WDigest off, RunAsPPL, Credential Guard) et durcie
- [ ] Rôle de la **domain backup key** DPAPI compris (Tier 0) ; master keys localisées
- [ ] Sysmon 10 (LSASS) et 11 (DPAPI) observés · `Get-/Enable-CredProtection.ps1` rejoués
- [ ] Drills faits (dont break-fix PPL) · ≥ 1 règle Sigma · prérequis : modules 56, 81. Suite : `83-etw-amsi`.
