# Module 14 — Objets Active Directory (Phase 1)

Peupler le domaine : OU, utilisateurs, groupes (modèle AGDLP), comptes de service.

## Contenu
- `fiche.md` — classes & attributs, SID/GUID/DN/UPN, portées de groupes, comptes sensibles, versioning.
- `drills.md` — SID/RID, portée de groupe par l'erreur, recherche LDAP, création en boucle, break-fix.
- `build.md` — OU géographiques, utilisateurs, groupes AGDLP, aperçu gMSA.
- `automate/New-CorpObjects.ps1` — structure de départ idempotente.
- `attack.md` / `defend.md` — recon annuaire (SPN, AS-REP, groupes sensibles) + durcissement/détection.

## Definition of Done
- [ ] Structure d'OU conforme à `architecture.md`, utilisateurs créés
- [ ] Groupes AGDLP en place (rôle global → ressource domain local)
- [ ] `New-CorpObjects.ps1` rejoué (manuel → automatisé)
- [ ] Drills faits (dont break-fix compte verrouillé) · recon annuaire comprise
- [ ] Mapping ATT&CK (T1087/T1069…) · ≥ 1 règle Sigma (ajout groupe sensible)
- [ ] Prérequis : module 13. Suite : `15-ldap-bases`, puis `16-kerberos-intro`.
