# Module 17 — NTLM (introduction) (Phase 1)
Le protocole d'authentification hérité — très abusé, **déprécié en 2025**.
## Contenu
fiche (défi/réponse, hash NT, NetNTLMv1/v2, transport) · drills (Kerberos vs NTLM, capture
NetNTLMv2, signature SMB, audit, break-fix blocage) · build (observer, auditer, imposer
signature, couper LLMNR) · automate (`Get-NtlmUsage.ps1`) · attack (PtH, capture, relais) ·
defend (signature SMB/LDAP, EPA, Restrict NTLM audit→blocage + détection 4624/4625, Sigma).
## Definition of Done
- [ ] NTLM observé (accès par IP), audit NTLM activé, usage inventorié
- [ ] Signature SMB imposée, LLMNR/NBT-NS coupés
- [ ] `Get-NtlmUsage.ps1` rejoué · drills faits (dont capture) · ≥ 1 règle Sigma
- [ ] Prérequis : module 14. Approfondissement offensif : Phase 5 (54, 56).
