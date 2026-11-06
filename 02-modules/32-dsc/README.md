# Module 32 — DSC (Phase 3)
Configuration déclarative et anti-dérive des machines.
## Contenu
fiche (déclaratif, ressources, MOF, LCM, push/pull, v1 vs v3) · drills (déclaratif vs impératif,
anti-dérive, ActiveDirectoryDsc, LCM auto-correct, break-fix MOF) · build (config rôle+service+
registre, appliquer, anti-dérive, LCM) · automate (`BaseServer.ps1`) · attack/defend (détournement
d'outil de config → Pull server Tier 0 + MOF chiffrés + détection .mof).
## Definition of Done
- [ ] Une config DSC compilée, appliquée, et **anti-dérive** démontrée
- [ ] `ActiveDirectoryDsc` utilisé (OU/groupe en déclaratif) ; LCM compris
- [ ] `BaseServer.ps1` rejoué · drills faits (dont break-fix MOF) · ≥ 1 règle Sigma
- [ ] Prérequis : module 30. Suite : `33-ansible-windows`, `34-terraform-iac`.
