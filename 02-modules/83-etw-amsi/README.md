# Module 83 — ETW & AMSI (Phase 8)
La télémétrie Windows, son contournement, et comment le détecter.
## Contenu
fiche (ETW providers/sessions/ETW-TI, AMSI, techniques d'évasion) · drills (sessions ETW, test AMSI,
absence=signal, ETW-TI vs user-mode, break-fix logging) · build (observer ETW/AMSI, détecter l'évasion,
renforcer la collecte) · automate (`Get-TelemetryHealth.ps1`) · attack (ETW patch/AMSI bypass/unhooking
— compréhension) · defend (multi-sources + détection par incohérence + Sigma AMSI bypass).
## Definition of Done
- [ ] Sessions ETW & logging PS vérifiés ; AMSI validé (chaîne de test bloquée)
- [ ] Principe « absence d'event = signal » compris ; ETW-TI vs user-mode compris
- [ ] `Get-TelemetryHealth.ps1` rejoué · drills faits (dont break-fix logging) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 30, 71, 80. Suite : `84-edr-comprehension-detection`.
