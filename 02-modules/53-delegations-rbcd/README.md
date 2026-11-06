# Module 53 — Délégations Kerberos & RBCD (Phase 5)
Abuser des mécanismes de délégation pour escalader (lab isolé).
## Contenu
fiche (unconstrained/constrained/RBCD, S4U, MachineAccountQuota, attributs) · drills (inventaire,
quota, RBCD complet, nettoyage, break-fix getST) · build (findDelegation, addcomputer, rbcd write,
getST, unconstrained+coercition) · automate (`rbcd-chain.sh`) · attack (chaînes RBCD & unconstrained)
· defend (MachineAccountQuota=0 + ACL + Protected Users + détection 5136/4741).
## Definition of Done
- [ ] Délégations inventoriées (findDelegation/BloodHound) ; MachineAccountQuota lu
- [ ] Chaîne **RBCD** complète réussie (accès admin sur une cible) puis nettoyée
- [ ] `rbcd-chain.sh` rejoué (lab) · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 21, 51, 52. Suite : `54-coercition-ntlm-relay`.
