# Module 57 — Persistance & dominance (Phase 5)
Rester dans le domaine… et savoir éradiquer proprement (lab isolé).
## Contenu
fiche (Golden/Silver/Diamond, AdminSDHolder, certs, sIDHistory, DCShadow, rôle de krbtgt) · drills
(Golden, éradication krbtgt x2, Silver vs Golden, AdminSDHolder, break-fix 1 rotation) · build (poser
la persistance puis l'éradiquer) · automate (`persist-notes.md`) · attack (panorama persistance) ·
defend (rotation krbtgt x2 + révocation certs + audit AdminSDHolder + détection 5136).
## Definition of Done
- [ ] Golden Ticket fonctionnel puis **invalidé** par rotation krbtgt x2 (avec délai)
- [ ] Silver/AdminSDHolder compris ; éradication complète (certs/ACL) comprise
- [ ] `persist-notes.md` suivi · drills faits (dont break-fix 1 rotation) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 26, 56. Suite : `58-cross-forest`.
