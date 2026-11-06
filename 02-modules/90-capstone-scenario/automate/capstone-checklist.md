# Capstone — checklist de déroulé

## Acte 0 — Baseline
- [ ] PingCastle/Purple Knight (score avant)
- [ ] BloodHound (chemins vers Tier 0, avant)
- [ ] Snapshots clean pris

## Acte 1 — Compromission (journaliser chaque étape, module 50)
- [ ] Recon (51)
- [ ] Accès initial (52 / autre)
- [ ] Escalade (21/43/55)
- [ ] Dominance (54/43 -> 56 DCSync krbtgt)
- [ ] Persistance (57)
- [ ] (option) Hybride (63) / cross-forest (58)

## Acte 2 — Détection (phase 7)
- [ ] Chaque étape vérifiée dans le SIEM (module 72)
- [ ] coverage.md rempli ; angles morts listés

## Acte 3 — Remédiation (phases 2-4-6 + éradication)
- [ ] Durcissements appliqués (tiering/LAPS/AES-gMSA/ESC/signature-NTLM/mapping/CA-PIM)
- [ ] Éradication (krbtgt x2, révocation certs, nettoyage ACL)
- [ ] Angles morts comblés (nouvelles règles)

## Acte 4 — Re-test
- [ ] Rejeu de la chaîne contre CORP durci : échecs + alertes
- [ ] PingCastle/BloodHound (après) comparés

## Livrables
- [ ] Rapport de pentest (template module 50)
- [ ] Rapport de remédiation (avant/après)
- [ ] Matrice de couverture ATT&CK
- [ ] Journal de bord complet
