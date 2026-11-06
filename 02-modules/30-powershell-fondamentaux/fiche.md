# Fiche — PowerShell : fondamentaux pour l'automatisation AD

> Volet académique. PowerShell est le langage d'automatisation de Windows/AD. Ce module pose les
> bases solides nécessaires pour tout scripter proprement (modules 31-35 et au-delà).

## 1. Rôle & utilité
PowerShell combine un **shell** et un **langage de script orienté objet**. Contrairement aux shells
texte (bash), il manipule des **objets .NET** : les commandes renvoient des objets qu'on filtre,
trie et transforme sans parsing fragile.

## 2. Concepts fondamentaux
- **Cmdlets** : commandes nommées `Verbe-Nom` (`Get-ADUser`, `New-Item`). Verbes standardisés
  (`Get`, `Set`, `New`, `Remove`, `Add`…).
- **Pipeline d'objets** : la sortie d'une cmdlet (objets) alimente la suivante
  (`Get-ADUser -Filter * | Where-Object Enabled | Select-Object Name`).
- **Objets & propriétés** : `Get-Member` révèle propriétés/méthodes d'un objet.
- **Variables** (`$x`), **types** (.NET), **tableaux**, **hashtables** (`@{}`).
- **Opérateurs** : comparaison (`-eq`, `-ne`, `-gt`, `-like`, `-match`), logiques (`-and`, `-or`).
- **Structures** : `if/else`, `switch`, `foreach`, `while`, `do`.
- **Fonctions** & paramètres (`param()`, `[CmdletBinding()]`, `[Parameter(Mandatory)]`).
- **Modules** : `Import-Module` (ex. `ActiveDirectory`, `GroupPolicy`, `DnsServer`).

## 3. Idempotence & robustesse
- **Idempotent** : un script qu'on peut relancer sans effet de bord (vérifier avant de créer).
- **Gestion d'erreurs** : `$ErrorActionPreference`, `try/catch/finally`, `-ErrorAction`.
- **WhatIf/Confirm** : `-WhatIf` simule, `-Confirm` demande confirmation (cmdlets supportant
  `SupportsShouldProcess`).
- **Sécurité des secrets** : `Read-Host -AsSecureString`, module `SecretManagement` ; jamais de
  mot de passe en clair dans un script/dépôt (voir `.gitignore`).

## 4. PowerShell 5.1 vs 7.x
- **5.1** (Windows PowerShell) : intégré, basé .NET Framework ; certains modules Windows n'existent
  que là, ou via compatibilité.
- **7.x** (PowerShell Core) : multiplateforme, moderne, performant. Recommandé pour les nouveaux
  scripts ; utilise `WindowsCompatibility` si besoin d'un module 5.1.

## 5. Outillage qualité
- **PSScriptAnalyzer** : linter (bonnes pratiques, erreurs). 
- **Pester** : framework de tests (valider que le script fait ce qu'il doit).
- **VS Code** + extension PowerShell : édition/debug.

## 6. Pour l'admin AD
Modules clés : `ActiveDirectory`, `GroupPolicy`, `DnsServer`, `DhcpServer`, `LAPS`, `DFSN`/`DFSR`.
Pattern récurrent : `Get-*` pour lire, filtrer, puis `Set-/New-/Remove-*` pour agir.

## 7. Surface d'attaque (aperçu)
- PowerShell est aussi un **outil offensif** (living-off-the-land). D'où : **logging** (script block,
  module, transcription), **AMSI**, **Constrained Language Mode**, **execution policy** (voir defend).
- Les attaquants abusent de `-EncodedCommand`, du téléchargement en mémoire, etc. (P8).

## 8. Détection (aperçu)
Script Block Logging (4104), Module Logging (4103), transcription, création de process `powershell`
suspect (4688). Voir `defend.md`.

## 9. Versioning
PS 7.x est la cible moderne ; 5.1 reste présent sur Windows. Le logging avancé nécessite des
versions récentes + GPO adéquates.

## 10. Pour aller plus loin
*Mastering PowerShell Scripting*, *Learn PowerShell in a Month of Lunches*. Voir `bibliographie.md` (P3).
