# Module 25 — DFS (Namespaces & Replication) (Phase 2)
Chemins unifiés et réplication multi-sites des fichiers.
## Contenu
fiche (DFS-N/DFS-R, referral par site, backlog/conflits) · drills (localité par site,
réplication, conflit, ACL AGDLP, break-fix backlog) · build (rôles, partage AGDLP, namespace
domain-based, groupe de réplication) · automate (`New-DfsShare.ps1`, `Get-DfsrHealth.ps1`) ·
attack/defend (partages ouverts/rançongiciel → AGDLP+ABE+SMB signé + détection 4663).
## Definition of Done
- [ ] Namespace domain-based + dossier avec 2 cibles (localité par site)
- [ ] DFS-R entre 2 serveurs, backlog surveillé, conflit observé
- [ ] Permissions via AGDLP (RW/RO) · `New-DfsShare.ps1`/`Get-DfsrHealth.ps1` rejoués
- [ ] Drills faits (dont break-fix) · ≥ 1 règle Sigma · prérequis : modules 23, 26 (sites).
