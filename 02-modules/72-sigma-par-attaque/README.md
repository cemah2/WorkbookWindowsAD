# Module 72 — Sigma par attaque / detection as code (Phase 7)
Centraliser, convertir et PROUVER toutes les détections des phases 4-6.
## Contenu
fiche (format Sigma, pipeline détection as code, catalogue, qualité) · drills (lire/écrire, convertir,
prouver, faux positifs, break-fix) · build (sigma-cli, rassembler, convertir, déployer, prouver,
matrice) · automate (`rules/` consolidées, `convert-all.sh`, `coverage.md`) · attack (mapping
attaque→règle, évasion) · defend (detection engineering + combler les trous).
## Definition of Done
- [ ] Règles consolidées dans `automate/rules/` (validées `sigma check`), taguées ATT&CK
- [ ] Converties vers le SIEM et déployées ; matrice `coverage.md` initialisée
- [ ] Au moins 6 règles **prouvées** par rejeu (module 74) → statut ✅
- [ ] Drills faits (dont break-fix log absent) · prérequis : modules 70, 71. Suite : `73-threat-hunting`.
