# Build — Monter une capacité purple team (lab)

## Pré-requis
- SIEM + Sysmon + règles (modules 70-72). Lab offensif (phase 5) et CORP durci (phases 2-4).

## Étape 1 — Installer Atomic Red Team
```powershell
IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicredteam.ps1' -UseBasicParsing)
Install-AtomicRedTeam -getAtomics
```

## Étape 2 — Rejouer une technique
```powershell
# Exemple : Kerberoasting (T1558.003)
Invoke-AtomicTest T1558.003 -ShowDetails       # voir ce que fait le test
Invoke-AtomicTest T1558.003                     # exécuter
Invoke-AtomicTest T1558.003 -Cleanup            # nettoyer
```

## Étape 3 — Vérifier la détection dans le SIEM
Après le test, confirmer que la règle Sigma correspondante (module 72) a généré une alerte, dans un
délai raisonnable, avec les bons champs.

## Étape 4 — Statuer et documenter
Mettre `coverage.md` à jour : ✅ si prouvée, sinon créer/corriger la règle (module 72) et re-tester.

## Étape 5 — Chaîne complète (Caldera, option)
Déployer Caldera + un agent, lancer une opération (chaîne de techniques) et observer la détection
bout-en-bout.

## Étape 6 — Visualiser la couverture
Générer une heatmap ATT&CK Navigator à partir des techniques prouvées.

## Étape 7 — Rejouer contre CORP durci
Exécuter les mêmes tests contre CORP (durci) : idéalement l'attaque **échoue** ET l'alerte **se lève**
(défense en profondeur).

## Vérification
- Chaque technique testée a un statut dans `coverage.md` ; au moins une chaîne Caldera observée.

## Pièges courants
- Rejouer sans vérifier le SIEM (test « pour le test »).
- Oublier le **cleanup** (laisser des artefacts).
- Ne pas re-tester après un changement (régression).
