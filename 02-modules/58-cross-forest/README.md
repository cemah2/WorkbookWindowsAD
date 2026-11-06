# Module 58 — Trusts & cross-forest (Phase 5, fin)
Franchir la frontière entre domaines/forêts (scénario M&A Nimbus) — lab isolé.
## Contenu
fiche (types de trusts, direction/transitivité, SID filtering, SID history, trust key) · drills
(cartographier, vérifier filtering, SID history, durcir+re-tester, break-fix pivot M&A) · build
(énumérer, vérifier filtering, abus SID history, pivot, durcir) · automate (`trust-notes.md`) ·
attack (pivot cross-forest via SID history) · defend (SID filtering + Selective Auth + détection
4765/4766/5136).
## Definition of Done
- [ ] Trusts cartographiés ; état du **SID filtering** vérifié
- [ ] Abus SID history réussi (filtering off) puis **bloqué** après durcissement
- [ ] `trust-notes.md` suivi · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] **Fin de la Phase 5.** Prérequis : modules 56, 57. Suite : Phase 6 (hybride/Entra).
