# Module 62 — Hybrid Join, SSO & PRT (Phase 6)
Comprendre la jonction hybride et le Primary Refresh Token (socle du SSO… et des attaques cloud).
## Contenu
fiche (AADJ/HAADJ/registered, PRT, CloudAP, Seamless SSO) · drills (dsregcmd, SSO, TrustType, PRT/TPM,
break-fix) · build (configurer HAADJ, vérifier PRT, SSO, côté Entra) · automate (`Get-DeviceState.ps1`)
· attack (Pass-the-PRT, device code phishing) · defend (TPM + CA device-compliant + token protection).
## Definition of Done
- [ ] Postes HAADJ (`dsregcmd /status` : AADJ+DomainJoined, AzureAdPrt YES) ; SSO cloud fonctionnel
- [ ] État des appareils côté Entra (TrustType) ; rôle du TPM compris
- [ ] `Get-DeviceState.ps1` rejoué · drills faits (dont break-fix) · ≥ 1 détection (KQL)
- [ ] Prérequis : module 61. Suite : `63-attaques-hybrides`.
