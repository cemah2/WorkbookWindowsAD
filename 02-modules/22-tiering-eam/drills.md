# Drills — Tiering

## Drill 1 — Cartographier qui se connecte où (10 min)
- **Étapes** : liste les comptes d'admin et sur quels hôtes ils ouvrent des sessions (4624).
- **Observer** : repère tout credential T0 vu sur un hôte non-T0.
- **Pourquoi** : mesurer l'écart avec le modèle cible.

## Drill 2 — Appliquer un deny logon et le prouver (15 min)
- **Étapes** : lie la GPO deny logon T1 ; tente une session T0 sur un serveur T1.
- **Observer** : refus + 4625.
- **Pourquoi** : vérifier que le contrôle "tient" techniquement.

## Drill 3 — Protected Users en action (10 min)
- **Étapes** : mets un compte dans Protected Users ; observe qu'il ne peut plus s'authentifier en
  NTLM / être délégué.
- **Pourquoi** : comprendre cette protection anti-vol de credential.

## Drill 4 — Silo d'authentification (15 min)
- **Étapes** : crée un silo T0, assigne un compte, teste que son TGT n'est utilisable que depuis
  les hôtes du silo.
- **Pourquoi** : enfermer le Tier 0.

## Drill break-fix — Lockout admin (10 min)
- **Casse** : applique un deny logon trop large qui bloque aussi ton accès d'admin légitime.
- **Diagnostique** : plus d'ouverture de session ; identifie la GPO fautive via un DC de secours.
- **Répare** : corrige la GPO (ou restaure via compte break-glass), re-teste. Leçon : prévoir
  TOUJOURS un accès de secours avant d'appliquer le tiering.
