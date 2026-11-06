# Module 21 — OU & délégation (Phase 2)
Organiser l'annuaire et déléguer l'administration au moindre privilège.
## Contenu
fiche (OU, ACL/ACE, permissions étendues, SDProp) · drills (lire ACE, déléguer+tester,
GenericAll, SDProp, break-fix) · build (délégation GUI + dsacls + vérif + nettoyage) ·
automate (`Set-OuDelegation.ps1`, `Get-AclReport.ps1`) · attack/defend (abus d'ACL/BloodHound →
moindre privilège + audit + détection 5136).
## Definition of Done
- [ ] Délégation ciblée posée (GUI **et** dsacls), testée dans/hors périmètre
- [ ] ACE non héritées auditées (`Get-AclReport.ps1`), SDProp compris
- [ ] Drills faits (dont break-fix délégation large) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 14, 20. Suite : `22-tiering-eam`.
