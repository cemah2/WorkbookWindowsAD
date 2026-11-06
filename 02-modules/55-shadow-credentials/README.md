# Module 55 — Shadow Credentials (Phase 5)
Abuser de msDS-KeyCredentialLink pour s'authentifier en tant qu'une cible (lab isolé).
## Contenu
fiche (Key Trust/PKINIT, msDS-KeyCredentialLink, prérequis ACL) · drills (edge BloodHound, certipy
shadow auto, lire l'attribut, break-fix PKINIT) · build (repérage, chaîne auto/manuelle, exploitation,
nettoyage) · automate (`shadow-notes.md`) · attack (chaîne complète) · defend (ACL strictes + mapping
fort + Protected Users + détection 5136/4768).
## Definition of Done
- [ ] Edge AddKeyCredentialLink identifié ; chaîne `certipy shadow auto` réussie (NT hash obtenu)
- [ ] Attribut **nettoyé** après l'exercice ; prérequis PKINIT compris
- [ ] `shadow-notes.md` suivi · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 21, 40, 51. Suite : `56-dump-credentials`.
