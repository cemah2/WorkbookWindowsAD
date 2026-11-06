# Drills — PowerShell fondamentaux

## Drill 1 — Objets, pas du texte (10 min)
- **Étapes** : `Get-Service | Get-Member` ; filtre `Where-Object Status -eq Running` ; `Select-Object`.
- **Observer** : on manipule des objets, pas des chaînes.
- **Pourquoi** : la différence fondamentale avec bash.

## Drill 2 — Pipeline AD (10 min)
- **Étapes** : `Get-ADUser -Filter * -Properties lastLogonDate | Sort lastLogonDate | Select -First 5`.
- **Pourquoi** : enchaîner lecture/tri/sélection.

## Drill 3 — Fonction avec paramètres (15 min)
- **Étapes** : écris une fonction `New-LabUser` avec `[CmdletBinding()]`, `param([Parameter(Mandatory)]...)`,
  `SupportsShouldProcess` (-WhatIf).
- **Pourquoi** : structurer du code réutilisable et sûr.

## Drill 4 — Idempotence (10 min)
- **Étapes** : écris un bloc qui crée une OU seulement si elle n'existe pas ; relance-le 2x.
- **Observer** : aucune erreur à la 2e exécution.
- **Pourquoi** : base de l'automatisation fiable.

## Drill 5 — Linter (5 min)
- **Étapes** : `Invoke-ScriptAnalyzer` sur un de tes scripts ; corrige un avertissement.
- **Pourquoi** : prendre l'habitude de la qualité.

## Drill break-fix — ExecutionPolicy bloque le script (10 min)
- **Casse** : `Set-ExecutionPolicy Restricted -Scope CurrentUser`, tente de lancer un .ps1.
- **Diagnostique** : erreur d'exécution ; `Get-ExecutionPolicy -List`.
- **Répare** : `RemoteSigned` (CurrentUser) ou signe le script ; comprends le compromis sécurité.
