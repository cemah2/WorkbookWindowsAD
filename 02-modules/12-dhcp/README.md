# Module 12 — DHCP (Phase 1)
Attribution d'adresses, intégration AD, haute dispo.
## Contenu
fiche (DORA, scopes, autorisation AD, failover) · drills (DORA, réservation, break-fix pool) ·
build (install, autorisation, étendue, failover) · automate (`Set-DhcpBaseline.ps1`) ·
attack/defend (rogue DHCP & starvation → snooping/autorisation + détection 1042).
## Definition of Done
- [ ] Rôle installé + **autorisé dans AD**, étendue EMEA active, options 003/006/015
- [ ] Réservation testée · (option) failover · `Set-DhcpBaseline.ps1` rejoué
- [ ] Drills faits (dont break-fix) · ≥ 1 règle Sigma · prérequis module 13
