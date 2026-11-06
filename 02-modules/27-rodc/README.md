# Module 27 — RODC (Phase 2)
Contrôleur en lecture seule pour sites exposés (agence Lyon).
## Contenu
fiche (réplication unidirectionnelle, PRP, krbtgt dédié, FAS) · drills (comptes en cache, PRP,
compte sensible, break-fix localité) · build (promotion RODC, PRP, audit comptes révélés) ·
automate (`Set-RodcPrp.ps1`) · attack/defend (vol de RODC → PRP stricte + Denied sensibles +
détection comptes révélés).
## Definition of Done
- [ ] RODC Lyon promu dans son site, authentification locale OK
- [ ] PRP stricte (agence autorisée, Tier 0 en Denied), comptes révélés audités
- [ ] `Set-RodcPrp.ps1` rejoué · drills faits (dont break-fix localité) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 13, 26. Suite : `28-fsmo`.
