# Module 22 — Tiering / Enterprise Access Model (Phase 2)
La mesure défensive la plus structurante : isoler les plans d'administration (Tier 0/1/2).
## Contenu
fiche (3 tiers, règles d'or, deny logon, silos, PAW) · drills (cartographie, deny logon,
Protected Users, silo, break-fix lockout) · build (OU/groupes/comptes par tier, GPO deny logon
croisées, Protected Users/silo, PAW) · automate (`New-TierStructure.ps1`, `Set-DenyLogonGpo.ps1`) ·
attack (vol de credential latéral) · defend (opération + détection session T0 hors périmètre).
## Definition of Done
- [ ] OU/groupes/comptes d'admin séparés par tier
- [ ] GPO deny logon **croisées** appliquées et prouvées (session interdite refusée)
- [ ] Comptes T0 dans Protected Users (+ silo en option) · PAW désigné
- [ ] **Accès break-glass** en place AVANT d'appliquer sur les DC
- [ ] Drills faits (dont break-fix lockout) · ≥ 1 règle Sigma (session T0 hors périmètre)
- [ ] Prérequis : modules 20, 21. Suite : `23-groupes-agdlp`, `24-laps`.
