# Module 80 — Windows Internals (Phase 8)
Le socle interne pour comprendre et détecter (orienté défense).
## Contenu
fiche (user/kernel, Object Manager/SRM, process/DLL/handles, LSASS/LSA, PPL, ETW) · drills (arbre de
process, handles LSASS, DLL, Autoruns, syscalls) · build (Sysinternals : ProcExp/Procmon/Autoruns/
WinObj) · automate (`Get-ProcTree.ps1`) · attack (panorama internals→modules 81-84) · defend
(Credential Guard/VBS/WDAC/ASR + détection Sysmon).
## Definition of Done
- [ ] Savoir expliquer pour un process : parent, token, DLL, et le Sysmon correspondant
- [ ] Sysinternals pris en main (ProcExp/Procmon/Autoruns) ; `Get-ProcTree.ps1` rejoué
- [ ] Carte « mécanisme→technique→détection » établie · drills faits
- [ ] Prérequis : phases 5, 7. Suite : `81-tokens-privileges`.
