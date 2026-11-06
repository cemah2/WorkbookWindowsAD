# Module 23 — Groupes & AGDLP (Phase 2)
Faire des groupes une stratégie maintenable et auditable (A→G→DL→P).
## Contenu
fiche (AGDLP/IGDLA, portées, nommage, token bloat) · drills (effectif vs direct, portées,
AGDLP complet, nested/BloodHound, break-fix token) · build (chaîne AGDLP + permission NTFS +
vérif) · automate (`New-AgdlpAccess.ps1`, `Get-GroupSprawl.ps1`) · attack/defend (escalade par
imbrication → hygiène + détection 4728/4732).
## Definition of Done
- [ ] Chaîne AGDLP complète implémentée et testée (accès effectif)
- [ ] Permission posée sur le **domain local** (jamais sur compte/global)
- [ ] Imbrications auditées (`Get-GroupSprawl.ps1`) · drills faits (dont break-fix token)
- [ ] ≥ 1 règle Sigma · prérequis : modules 14, 21. Suite : `24-laps`, `25-dfs`.
