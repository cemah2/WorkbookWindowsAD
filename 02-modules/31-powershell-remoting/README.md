# Module 31 — PowerShell Remoting (Phase 3)
Administrer à distance et à l'échelle (fan-out, JEA).
## Contenu
fiche (WinRM/SSH, Invoke-Command, sessions, double-hop, JEA) · drills (fan-out, session, JEA,
double-hop, break-fix WinRM) · build (GPO WinRM, fan-out, sessions, JEA, double-hop propre) ·
automate (`Invoke-OnFleet.ps1`) · attack/defend (WinRM mouvement latéral/evil-winrm → segmentation
+ JEA + tiering + détection wsmprovhost).
## Definition of Done
- [ ] Fan-out `Invoke-Command` + sessions persistantes maîtrisés
- [ ] Un endpoint **JEA** restreint créé et testé ; double-hop compris
- [ ] `Invoke-OnFleet.ps1` rejoué sur un parc · drills faits (dont break-fix WinRM)
- [ ] ≥ 1 règle Sigma (wsmprovhost) · prérequis : modules 22, 30. Suite : `32-dsc`.
