# Defend — Boucle d'amélioration continue

## Démarche
1. **Rejouer** (Atomic/Caldera) les techniques des phases 4-6.
2. **Vérifier** les règles (module 72) : alerte, délai, champs, faux positifs.
3. **Statuer** dans `coverage.md` / `purple-plan.md` (✅ / angle mort).
4. **Corriger** : nouvelle règle, fix de logs (70-71), ou contrôle préventif (phases 2-4/6).
5. **Mesurer** : heatmap ATT&CK Navigator, % couverture, régression.
6. **Cadence** : campagne récurrente + après chaque changement.

## Indicateurs
- Taux de techniques détectées (couverture ATT&CK).
- Délai de détection ; nombre de faux positifs ; angles morts restants.

## Détection (méta)
Le purple **prouve** la détection : la sortie est la matrice de couverture et la liste des règles
validées — c'est le livrable Blue/Purple de référence.

### Validation
- `Run-PurpleCheck.ps1` pour rejouer ; `coverage.md` comme tableau de bord.

## Rejouer contre CORP durci
Idéal recherché : pour chaque technique, **l'attaque échoue** (phases 2-4/6) **et** **l'alerte se lève**
(phases 7). Les cas où ni l'un ni l'autre = priorité absolue.
