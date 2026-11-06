# Module 11 — DNS (Phase 1)

Approfondir le DNS, colonne vertébrale d'AD (installé avec le premier DC au module 13).

## Contenu
- `fiche.md` — zones, enregistrements, SRV, split-brain, forwarders, intégration AD, versioning.
- `drills.md` — anatomie d'une résolution, enregistrements, AXFR, SRV/sites, break-fix.
- `build.md` — zone inverse, forwarders, mises à jour sécurisées, scavenging, conditional forwarder.
- `automate/Set-DnsBaseline.ps1` — baseline DNS idempotente.
- `attack.md` / `defend.md` — recon DNS & mises à jour non sécurisées + durcissement/détection.

## Definition of Done
- [ ] Résolution directe/inverse OK, forwarder fonctionnel, SRV résolus
- [ ] Mises à jour dynamiques en **Secure only**, transferts de zone **bloqués**
- [ ] Scavenging activé · `Set-DnsBaseline.ps1` rejoué
- [ ] Drills faits (dont AXFR et break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : module 13. Suite : `12-dhcp` ou `14-objets-ad`.
