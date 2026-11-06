# Defend — Detection engineering

## Démarche
1. **Centraliser** les règles (ce module, `automate/rules/`), versionnées, taguées ATT&CK.
2. **Convertir** vers le SIEM (sigma-cli/pySigma) et déployer.
3. **Prouver** chaque règle par rejeu (module 74) → statut dans `coverage.md`.
4. **Affiner** : réduire les faux positifs, couvrir les variantes, surveiller la performance.
5. **Combler les trous** : techniques sans détection = backlog prioritaire.

## Bonnes pratiques
- Logs d'abord (modules 70-71) : une règle sans log ne sert à rien.
- Prioriser par **impact** (ATT&CK) et prévalence réelle.
- Documenter chaque règle (hypothèse, faux positifs connus, réponse attendue).

## Détection (méta)
Ce module **produit** les détections ; sa « preuve » est le taux de règles déclenchées lors des rejeux
(module 74) et la couverture ATT&CK.

### Validation
```bash
sigma check automate/rules/*.yml      # règles valides
# puis module 74 : rejeu -> coverage.md à jour
```

## Rejouer contre CORP durci
Les règles doivent **continuer** à détecter les tentatives (même échouées) contre CORP durci :
l'attaque échoue ET l'alerte se lève (défense en profondeur).
