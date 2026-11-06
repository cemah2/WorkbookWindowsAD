# Module 51 — Recon & énumération (Phase 5)
Cartographier l'AD et trouver le chemin vers le Tier 0 (lab isolé).
## Contenu
fiche (sources LDAP/DNS/SMB/Kerberos, BloodHound, attributs à risque) · drills (shortest path,
NetExec, kerbrute, attributs, break-fix collecte) · build (NetExec, LDAP, BloodHound, kerberos enum,
journal) · automate (`enum.sh`) · attack (recon priorisée) · defend (honeytokens + détection
1644/4768/SAMR).
## Definition of Done
- [ ] Collecte BloodHound réussie ; ≥ 1 shortest path to Domain Admins identifié
- [ ] Attributs à risque listés (SPN/no-preauth/RBCD/KeyCredentialLink) ; journal à jour
- [ ] `enum.sh` rejoué (lab) · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 15, 50. Suite : `52-kerberoasting-asrep`.
