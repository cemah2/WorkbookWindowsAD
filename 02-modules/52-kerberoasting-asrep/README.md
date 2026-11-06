# Module 52 — Kerberoasting & AS-REP Roasting (Phase 5)
Casser hors-ligne des éléments Kerberos pour obtenir des mots de passe (lab isolé).
## Contenu
fiche (Kerberoasting, AS-REP, RC4 vs AES, attributs) · drills (roaster, casser, AS-REP, RC4/AES,
break-fix) · build (GetUserSPNs/GetNPUsers + hashcat + réutilisation) · automate (`roast.sh`) ·
attack (chaîne complète) · defend (AES-only + gMSA + no-preauth off + détection 4769/4768).
## Definition of Done
- [ ] Un TGS roasté et (mot de passe faible) cassé ; un AS-REP roasté
- [ ] Effet AES vs RC4 observé ; credential réutilisé dans le chemin d'attaque
- [ ] `roast.sh` rejoué (lab) · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 16, 51. Suite : `53-delegations-rbcd`.
