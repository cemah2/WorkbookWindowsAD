# Module 73 — Threat Hunting (Phase 7)
Chercher proactivement ce que les règles n'ont pas vu.
## Contenu
fiche (hypothesis-driven, sources, stacking/baselining, hunting hybride) · drills (hunt
Kerberoasting/DCSync, least-frequency, BloodHound défensif, break-fix logs) · build (hypothèses,
requêtes SIEM, Velociraptor, BloodHound, conclure->règle) · automate (`hunts.md`,
`hunt-report-template.md`) · attack (variantes furtives à chasser) · defend (hunting opérationnel +
boucle vers la détection).
## Definition of Done
- [ ] ≥ 1 hunt mené de l'hypothèse à la conclusion, documenté (hunt report)
- [ ] Une attaque de la phase 5 retrouvée par hunting ; une variante furtive discutée
- [ ] Toute trouvaille → nouvelle règle (module 72) + `coverage.md` mis à jour
- [ ] Drills faits (dont break-fix logs) · prérequis : modules 70-72. Suite : `74-purple-team`.
