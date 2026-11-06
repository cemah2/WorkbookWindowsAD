# Module 71 — Sysmon (Phase 7)
La télémétrie endpoint qui alimente la détection AD.
## Contenu
fiche (Event IDs 1/3/7/8/10/11/12-14/22, config SwiftOnSecurity/Olaf Hartong, liens attaques) ·
drills (installer+lire, LSASS/Sysmon10, encoded/Sysmon1, comparer configs, break-fix muet) · build
(config éprouvée, install, vérifier, déployer à l'échelle, valider LSASS) · automate
(`Install-Sysmon.ps1`) · attack (évasion Sysmon/ETW) · defend (protéger service + alerte config +
EDR + détection 7034/16).
## Definition of Done
- [ ] Sysmon déployé avec une **config éprouvée** ; canal forwardé vers le SIEM
- [ ] Sysmon 10 (LSASS) et Sysmon 1 (encoded cmd) observés sur des attaques de lab
- [ ] `Install-Sysmon.ps1` rejoué · drills faits (dont break-fix muet) · ≥ 1 règle Sigma
- [ ] Prérequis : module 70. Suite : `72-sigma-par-attaque`.
