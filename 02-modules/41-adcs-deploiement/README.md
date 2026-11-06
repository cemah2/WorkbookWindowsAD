# Module 41 — Déploiement AD CS (Phase 4)
Installer la PKI 2 niveaux (Root hors-ligne + Issuing Enterprise) avec révocation et audit.
## Contenu
fiche (composants AD CS, process 2 niveaux, révocation, ESC8/ESC11/ESC7) · drills (vérifier chaîne,
CRL root hors-ligne, audit, ping CA, break-fix révocation) · build (root standalone, issuing sub,
signature du CSR, audit, extinction root) · automate (`Install-IssuingCA.ps1`) · attack/defend
(ESC8 relais NTLM vers Web Enrollment → HTTPS+EPA + signature + audit, détection 4886).
## Definition of Done
- [ ] Root CA hors-ligne + Issuing Enterprise opérationnelle ; chaîne vérifiée (`certutil -verify`)
- [ ] CDP/AIA joignables, CRL publiée, **audit AD CS activé** (AuditFilter 127)
- [ ] Web Enrollment non exposé en HTTP (ou HTTPS+EPA) · `Install-IssuingCA.ps1` rejoué
- [ ] Drills faits (dont break-fix révocation) · ≥ 1 règle Sigma · prérequis : module 40. Suite : `42`.
