# Drills — Purple Team

## Drill 1 — Atomic T1558.003 (15 min)
- **Étapes** : `Invoke-AtomicTest T1558.003` puis vérifie l'alerte Kerberoasting dans le SIEM.
- **Pourquoi** : prouver une règle de bout en bout.

## Drill 2 — Angle mort (15 min)
- **Étapes** : choisis une technique sans règle, rejoue-la, constate l'absence d'alerte, crée la règle.
- **Pourquoi** : le purple nourrit la détection.

## Drill 3 — Heatmap ATT&CK (10 min)
- **Étapes** : marque les techniques prouvées dans ATT&CK Navigator.
- **Pourquoi** : visualiser la couverture.

## Drill 4 — Rejeu contre CORP durci (15 min)
- **Étapes** : rejoue une attaque contre CORP durci ; vérifie échec + alerte.
- **Pourquoi** : prouver la défense en profondeur.

## Drill break-fix — Alerte absente après test (10 min)
- **Casse/Diagnostique** : test exécuté mais pas d'alerte → log manquant ou règle mal convertie.
- **Répare** : corriger audit/Sysmon (70-71) ou la règle/pipeline (72), re-tester.
