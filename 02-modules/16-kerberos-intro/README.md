# Module 16 — Kerberos (introduction) (Phase 1)
Le protocole d'authentification par défaut d'AD — et la cible n°1 des attaques.
## Contenu
fiche (AS/TGS, TGT/ST, KDC, krbtgt, PAC, pré-auth) · drills (cycle de ticket, capture
AS/TGS, skew horaire, AES vs RC4, break-fix SPN) · build (observer klist, forcer AES, audit) ·
automate (`Get-KerberosHealth.ps1`) · attack (panorama : Kerberoasting, AS-REP, Golden/Silver) ·
defend (AES, gMSA, rotation krbtgt, Protected Users + détection 4768/4769/4771, Sigma).
## Definition of Done
- [ ] Cycle TGT→ST observé (klist), AS/TGS capturés (Wireshark)
- [ ] AES imposé sur un compte, audit Kerberos activé, 4768/4769 visibles
- [ ] `Get-KerberosHealth.ps1` rejoué · drills faits (dont skew) · ≥ 1 règle Sigma
- [ ] Prérequis : module 14. Approfondissement offensif : Phase 5 (52+).
