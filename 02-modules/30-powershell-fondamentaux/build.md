# Build — Mettre en place un environnement PowerShell d'admin (dans CORP)

## Pré-requis
- Un poste d'admin (Windows) ou le DC avec RSAT. Accès au domaine.

## Étape 1 — Installer PowerShell 7 + outils qualité
```powershell
# PowerShell 7 (via winget sur Windows récent)
winget install --id Microsoft.PowerShell -e
# Modules qualité
Install-Module PSScriptAnalyzer, Pester -Scope CurrentUser -Force
# RSAT / module AD si besoin
Install-WindowsFeature RSAT-AD-PowerShell   # sur serveur ; sur Win10/11 : Add-WindowsCapability
```

## Étape 2 — Découvrir et explorer
```powershell
Get-Command -Module ActiveDirectory | Measure-Object        # nb de cmdlets AD
Get-ADUser jon.snow | Get-Member                            # propriétés/méthodes
Get-Help Get-ADUser -Examples                               # aide + exemples
```

## Étape 3 — Pipeline d'objets (lecture → action)
```powershell
# Désactiver les comptes inactifs > 90 jours (exemple, avec -WhatIf d'abord !)
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -UsersOnly |
  Where-Object Enabled |
  Disable-ADAccount -WhatIf
```

## Étape 4 — Écrire une fonction idempotente réutilisable
Voir `automate/New-CorpUser.ps1` : crée un user **seulement s'il n'existe pas**, gère le mot de
passe en SecureString, supporte `-WhatIf`.

## Étape 5 — Linter + tester
```powershell
Invoke-ScriptAnalyzer .\automate\New-CorpUser.ps1          # bonnes pratiques
Invoke-Pester .\automate\Tests\                            # tests unitaires
```

## Vérification
```powershell
$PSVersionTable.PSVersion          # 7.x
Get-Module -ListAvailable ActiveDirectory
```

## Pièges courants
- Scripter sans **-WhatIf** sur des actions de masse → dégâts.
- Mettre des secrets en clair dans les scripts.
- Mélanger 5.1/7.x sans vérifier la disponibilité des modules.
