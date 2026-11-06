# Module 91 — Windows Server 2025 & dMSA/BadSuccessor (Phase 9, fin)
Faire évoluer CORP vers 2025 et étudier la nouvelle surface d'attaque (dMSA).
## Contenu
fiche (niveau fonctionnel 2025, dMSA, BadSuccessor, 32K pages/NUMA, réduction NTLM, dépréciations) ·
drills (niveau fonctionnel, créer/observer dMSA, qui peut créer un dMSA, NTLM, break-fix délégation) ·
build (DC 2025, élever le FL sur copie jetable, créer dMSA, étudier BadSuccessor+réparer, comparer NTLM)
· automate (`Find-DmsaRisk.ps1`) · attack (BadSuccessor — compréhension) · defend (restreindre création
dMSA Tier 0 + surveiller attributs + détection 5136/5137).
## Definition of Done
- [ ] FL 2025 testé (copie jetable) ; dMSA créé et observé
- [ ] Prérequis BadSuccessor compris (ACL CreateChild dMSA) ; audit `Find-DmsaRisk.ps1` sans risque
- [ ] Réduction NTLM (2025) évaluée · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] **Fin du workbook.** Prérequis : phases 1-8 + module 90.
