# Module 56 — Extraction de credentials (Phase 5)
Récolter et réutiliser les secrets Windows (LSASS/SAM/DPAPI/NTDS) — lab isolé.
## Contenu
fiche (LSASS/SAM/DPAPI/NTDS/LSA, PtH/PtT/OverPtH) · drills (DCSync krbtgt, LSASS→PtH, SAM,
OverPtH, break-fix Credential Guard) · build (lsassy/secretsdump/DCSync/DPAPI + réutilisation) ·
automate (`dump-notes.md`) · attack (chaîne dump→PtH→DCSync→krbtgt) · defend (Credential Guard +
WDigest off + droits réplication + détection Sysmon10/4662).
## Definition of Done
- [ ] krbtgt obtenu via **DCSync** ; un hash LSASS réutilisé en **PtH/OverPtH**
- [ ] Effet de Credential Guard observé ; dumps **non committés**
- [ ] `dump-notes.md` suivi · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 26, 53/54. Suite : `57-persistance`.
