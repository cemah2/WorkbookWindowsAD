# Module 54 — Coercition & relais NTLM (Phase 5)
Forcer une auth machine et la relayer vers un service utile (lab isolé).
## Contenu
fiche (PetitPotam/PrinterBug/Coercer, relais NTLM, cibles AD CS/LDAP/SMB, signature) · drills
(gen-relay-list, coercition, relais LDAP→RBCD, relais ADCS/ESC8, break-fix signature) · build
(cibles relayables, ntlmrelayx, coercition, exploitation) · automate (`relay-notes.md`) · attack
(chaînes ESC8 & LDAP→RBCD) · defend (signature SMB/LDAP + EPA + NTLM réduit + détection 4624/4886).
Relié à `04-solutions/ESC8-petitpotam-relay.md`.
## Definition of Done
- [ ] Liste de cibles relayables générée ; une coercition réussie
- [ ] Une chaîne complète (ESC8 **ou** LDAP→RBCD) aboutie en lab puis neutralisée par la signature
- [ ] `relay-notes.md` suivi · drills faits (dont break-fix signature) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 17, 43, 53. Suite : `55-shadow-credentials`.
