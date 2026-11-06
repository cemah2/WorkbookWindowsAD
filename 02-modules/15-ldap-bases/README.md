# Module 15 — LDAP (Phase 1)
Le langage d'accès à l'annuaire : requêtes, filtres, signature.
## Contenu
fiche (DN, scopes, filtres, binds, ports, signature) · drills (scopes, filtres à bits, bind
anonyme, capture) · build (requêtes PowerShell/.NET/ldapsearch, signature requise, LDAPS) ·
automate (`Invoke-LdapAudit.ps1`) · attack/defend (recon/BloodHound → signing+channel binding
+ détection 2889/1644).
## Definition of Done
- [ ] Requêtes authentifiées OK, binds anonymes refusés
- [ ] Signature LDAP + channel binding exigés (GPO) · LDAPS testé
- [ ] `Invoke-LdapAudit.ps1` rejoué · drills faits (dont capture) · ≥ 1 règle Sigma
- [ ] Prérequis : module 14. Suite : `16-kerberos-intro`.
