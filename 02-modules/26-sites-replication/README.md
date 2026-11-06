# Module 26 — Sites & réplication (Phase 2)
Modéliser la topologie réseau, piloter la réplication multi-sites.
## Contenu
fiche (sites/subnets/site links, KCC/ISTG, USN, intra vs inter-site) · drills (replsummary,
propagation, localisation de DC, coût, break-fix subnet) · build (sites, subnets, déplacement DC,
site links, repadmin) · automate (`Set-SitesTopology.ps1`, `Get-ReplHealth.ps1`) ·
attack/defend (DCSync/DCShadow → restreindre droits de réplication + détection 4662).
## Definition of Done
- [ ] ≥ 2 sites avec subnets, DC déplacés, site links (coût/intervalle)
- [ ] `repadmin /replsummary` sain ; propagation observée ; localisation par site OK
- [ ] `Set-SitesTopology.ps1`/`Get-ReplHealth.ps1` rejoués · drills faits (dont break-fix subnet)
- [ ] ≥ 1 règle Sigma (DCSync) · prérequis : module 13 (multi-DC). Suite : `27-rodc`.
