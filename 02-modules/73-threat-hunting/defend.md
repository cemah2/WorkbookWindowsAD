# Defend — Hunting opérationnel

## Démarche
1. **Baseline** le normal (process, logons, réseau) pour repérer l'anormal.
2. **Hunts réguliers** (bibliothèque `hunts.md`), priorisés par TTP pertinents.
3. **Documenter** (hunt report) et **nourrir la détection** (nouvelle règle Sigma, module 72).
4. **Mettre à jour `coverage.md`** (matrice ATT&CK).
5. **Boucler** avec la réponse à incident quand une menace est confirmée.

## Détection (méta)
Le hunting **produit** des détections et des incidents. Sa mesure : nombre de hunts, trouvailles,
nouvelles règles, et réduction des angles morts ATT&CK.

### Outillage de validation
- Rejeu (module 74) pour s'assurer que les nouvelles règles se déclenchent.
- Velociraptor pour la chasse/collecte à l'échelle.

## Rejouer contre CORP durci
Même durci, CORP doit être « huntable » : logs riches + baseline → les tentatives (même échouées)
laissent des traces exploitables.
