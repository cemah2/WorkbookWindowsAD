# Build — Centraliser, convertir et déployer les règles Sigma

## Pré-requis
- SIEM opérationnel (module 70) + Sysmon (module 71). sigma-cli installé.

## Étape 1 — Installer l'outillage
```bash
pipx install sigma-cli
sigma plugin install elasticsearch   # ou splunk / etc. selon ton SIEM
```

## Étape 2 — Rassembler les règles
Les règles des modules 4-6 sont consolidées dans `automate/rules/`. Les versionner ici (une par
fichier .yml), avec le tag ATT&CK.

## Étape 3 — Convertir vers le backend
```bash
sigma convert -t elasticsearch -p ecs_windows automate/rules/kerberoasting.yml
# -> requête prête à coller/importer dans le SIEM
```

## Étape 4 — Déployer dans le SIEM
Importer les requêtes générées comme détections/alertes (Elastic rules, Wazuh rules, etc.).

## Étape 5 — Prouver (lien module 74)
Rejouer l'attaque (Atomic Red Team ou outil de lab) → vérifier que la règle se déclenche. Si non :
corriger la règle **ou** les logs (audit/Sysmon manquant).

## Étape 6 — Matrice de couverture
Maintenir un tableau technique ATT&CK → règle → statut (prouvée / à faire).

## Vérification
```bash
sigma check automate/rules/*.yml        # validité des règles
# Chaque règle déployée se déclenche sur l'attaque correspondante (module 74)
```

## Pièges courants
- Règle correcte mais **log absent** (audit/Sysmon) → jamais déclenchée.
- logsource Sigma ne matchant pas la normalisation du SIEM (pipeline/pySigma à ajuster).
- Règles jamais testées.
