# Module 84 — EDR : comprendre pour détecter (Phase 8, fin)
Synthèse défensive : fonctionnement, angles morts et détection résiliente.
## Contenu
fiche (capteurs kernel/user/ETW-TI, modèles de détection, angles morts, EDR vs Sysmon vs SIEM) · drills
(capteurs, comportemental, tamper protection, recoupement, break-fix angle mort) · build (cartographier,
protéger l'agent, tester détection/angles morts, combiner, réponse) · automate (`edr-coverage.md`) ·
attack (unhooking/BYOVD/tampering — compréhension) · defend (kernel+ETW-TI + tamper + WDAC/ASR +
defense-in-depth + détection 7036).
## Definition of Done
- [ ] Capteurs de l'EDR cartographiés ; tamper protection activée
- [ ] Détection comportementale validée (ex. Office→PowerShell→LSASS) ; recoupement multi-sources établi
- [ ] `edr-coverage.md` rempli via le purple team ; angles morts listés
- [ ] Drills faits (dont break-fix) · ≥ 1 règle Sigma · **Fin de la Phase 8.** Prérequis : modules 80-83. Suite : Phase 9 (capstone).
