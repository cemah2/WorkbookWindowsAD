# Module 70 — Collecte de logs & SIEM (Phase 7)
Le socle de la détection : centraliser les bons logs.
## Contenu
fiche (quoi collecter, WEF vs agents, SIEM Wazuh/Elastic, pipeline Sigma) · drills (auditpol, event
test, alerte 1102, dashboard, break-fix agent) · build (audit baseline, déployer SIEM, enrôler DC/
endpoints, Sysmon, alerte 1102) · automate (`Set-AuditBaseline.ps1`, `wef-notes.md`) · attack
(anti-forensics T1070/T1562) · defend (forward immédiat + SIEM Tier 0 + détection 1102/4719).
## Definition of Done
- [ ] Audit policy avancée activée (GPO) ; SIEM déployé ; DC + endpoints + Sysmon ingérés
- [ ] Event test retrouvé dans le SIEM ; alerte **1102** en place
- [ ] `Set-AuditBaseline.ps1` rejoué · drills faits (dont break-fix agent) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 16, 20. Suite : `71-sysmon`, `72-sigma-par-attaque`.
