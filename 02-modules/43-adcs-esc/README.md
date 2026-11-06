# Module 43 — AD CS : attaques ESC1→ESC16 (Phase 4)
Le catalogue des escalades par certificat : exploiter, détecter, remédier (lab isolé).
## Contenu
fiche (catalogue ESC1-16, 4 familles, KB5014754/mapping fort) · drills (certipy find, ESC1 complet,
réparer+re-tester, ESC8 coercition/relais, break-fix mapping) · build (monter un terrain ESC en lab
isolé puis réparer) · automate (`Invoke-EscAudit.ps1`) · attack (ESC1/ESC8/ESC7/ESC6 avec
Certipy/ntlmrelayx) · defend (durcissement par famille + détection 4886/5136 + boucle re-test).
Relié à `04-solutions/` (améliorations GOAD).
## Definition of Done
- [ ] `certipy find -vulnerable` maîtrisé ; **ESC1** exploité de bout en bout (lab isolé)
- [ ] **ESC8** (PetitPotam + relais) compris ; mapping fort (KB5014754) compris
- [ ] Chaque ESC fabriqué a été **réparé** et re-testé (find vide, attaque échoue)
- [ ] `Invoke-EscAudit.ps1` rejoué · drills faits (dont break-fix mapping) · ≥ 1 règle Sigma
- [ ] **Fin de la Phase 4.** Prérequis : modules 41, 42. Suite : Phase 5 (offensif on-prem).
