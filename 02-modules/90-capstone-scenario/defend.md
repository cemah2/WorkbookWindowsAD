# Defend — Détecter, remédier, prouver (capstone)

## Détection (Acte 2)
- Vérifier, étape par étape, le déclenchement des règles (module 72) ; mesurer le **time-to-detect**.
- Remplir la **matrice ATT&CK** ; lister les angles morts.

## Remédiation (Acte 3)
- Appliquer les durcissements des phases 2-4-6 (tiering, LAPS, AES/gMSA, ESC fix, signature/NTLM,
  mapping fort, CA/PIM) + **éradication** (krbtgt x2, révocation certs, nettoyage ACL/persistance).
- Combler les angles morts (nouvelles détections).

## Re-test & preuve (Acte 4)
- Rejouer la chaîne contre CORP durci : chaque étape **échoue** ET **alerte**.
- **PingCastle/BloodHound avant/après** : score amélioré, chemins vers Tier 0 fermés.

## Livrables (compétence d'expert)
- Rapport de pentest + rapport de remédiation (avant/après) + matrice ATT&CK + journal.

### Indicateurs de réussite
```text
[ ] Chaîne complète documentée + mappée ATT&CK
[ ] Couverture détection élevée (coverage.md)
[ ] Re-test : attaque initiale neutralisée + alertes
[ ] PingCastle score ↑ / BloodHound chemins ↓
```

## Rejouer contre CORP durci
C'est l'Acte 4 : la preuve finale que tout le travail des phases 2-8 tient face à l'attaque de la phase 5.
