# Module 29 — Sauvegarde & PRA (Phase 2)
Récupérer AD : objet, DC, forêt. La dernière ligne de défense.
## Contenu
fiche (system state, types de restauration, DSRM, Recycle Bin, Forest Recovery) · drills
(Recycle Bin, autoritaire, metadata cleanup, restauration VM, break-fix "DC explosé") · build
(Recycle Bin, backup system state + PBS, restaurations, test) · automate (`Enable-RecycleBin.ps1`,
`Backup-ADSystemState.ps1`) · attack/defend (destruction de sauvegardes/rançongiciel →
sauvegardes immuables testées + détection vssadmin/5141).
## Definition of Done
- [ ] AD Recycle Bin activée ; ≥ 2 DC sauvegardés (system state + VM PBS)
- [ ] Restauration d'objet, autoritaire et VM **testées** ; metadata cleanup maîtrisé
- [ ] `Enable-RecycleBin.ps1`/`Backup-ADSystemState.ps1` rejoués · drills faits (dont "DC explosé")
- [ ] ≥ 1 règle Sigma (vssadmin) · prérequis : modules 26, 28. **Fin de la Phase 2.**
