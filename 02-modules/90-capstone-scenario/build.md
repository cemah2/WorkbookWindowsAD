# Build — Jouer le capstone (CORP + GOAD-X)

## Pré-requis
- Toutes les phases en place : CORP (phases 1-4,6), GOAD-X (phase 5), SIEM+détection (phase 7),
  durcissements disponibles. Snapshots « clean » prêts.

## Étape 0 — Mesure initiale (baseline)
- **PingCastle** / Purple Knight sur CORP → score de départ.
- **BloodHound** → chemins vers Domain Admins / Tier 0 (capture « avant »).

## Étape 1 — Acte 1 : Compromission (lab)
Dérouler une chaîne complète (adapter selon ton lab), ex. :
1. Recon (51) : BloodHound → repérer un chemin.
2. Accès initial : Kerberoasting (52) ou AS-REP → credential.
3. Escalade : ACL/Shadow Creds (21/55) ou ESC1 (43).
4. Dominance : coercition+ESC8 (54/43) → cert DC → DCSync krbtgt (56).
5. Persistance : Golden Ticket (57).
6. (option) Pivot hybride (63) / cross-forest (58).
Journaliser chaque étape (module 50).

## Étape 2 — Acte 2 : Détection
- Pour chaque étape, vérifier l'alerte dans le SIEM (règles module 72) ; remplir `coverage.md`.
- Noter les étapes **non** détectées (angles morts).

## Étape 3 — Acte 3 : Remédiation
- Appliquer les durcissements correspondants (tiering, LAPS, AES/gMSA, ESC fix, signature/NTLM,
  mapping fort, CA/PIM) + **éradication** (rotation krbtgt x2, révocation certs).
- Combler les angles morts (nouvelles règles, module 72).

## Étape 4 — Acte 4 : Re-test
- Restaurer un état « compromis-able » (snapshot) **puis appliquer le durcissement**, et rejouer la
  chaîne : vérifier que chaque étape échoue ET alerte.

## Étape 5 — Mesure finale & livrables
- **PingCastle**/BloodHound « après » → comparer au départ (score + chemins).
- Produire : rapport de pentest, rapport de remédiation, matrice ATT&CK, journal.

## Vérification
- Chaîne complète jouée ET documentée ; remédiation prouvée par le re-test ; score PingCastle amélioré ;
  chemins BloodHound vers le Tier 0 réduits/supprimés.

## Pièges courants
- Jouer l'attaque sans **documenter** (pas de rapport = capstone raté).
- Remédier sans **re-tester** (non prouvé).
- Oublier l'**éradication** (persistance résiduelle).
