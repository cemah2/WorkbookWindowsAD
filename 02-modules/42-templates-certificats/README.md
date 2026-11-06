# Module 42 — Templates de certificats (Phase 4)
Définir qui obtient quel certificat — le cœur des escalades ESC.
## Contenu
fiche (EKU, ENROLLEE_SUPPLIES_SUBJECT, ACL, approval, auto-enroll, ESC1-4/9-10) · drills (lire un
template, fabriquer/réparer un ESC1, enrôler, auto-enroll, break-fix) · build (dupliquer templates
sûrs, publier, auto-enroll GPO, auditer) · automate (`Audit-CertTemplates.ps1`) · attack/defend
(ESC1 via Certipy → Build from AD + Enroll ciblé + approval + mapping fort, détection 4886/5136).
## Definition of Done
- [ ] Templates sûrs créés (Build from AD, Enroll ciblé) et publiés
- [ ] Un ESC1 compris (fabriqué puis réparé en lab) ; auto-enrollment maîtrisé
- [ ] `Audit-CertTemplates.ps1` rejoué (aucun PotentialESC1 non justifié) · drills faits
- [ ] ≥ 1 règle Sigma · prérequis : module 41. Suite : `43-adcs-esc`.
