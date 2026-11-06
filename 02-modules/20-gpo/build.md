# Build — Créer, lier et filtrer des GPO (dans CORP)

## Pré-requis
- `corp.meridian.com` avec la structure d'OU du module 14. Module `GroupPolicy` présent (RSAT-GPMC).

## Étape 1 — Première GPO (GUI) : bannière d'ouverture de session
Dans **GPMC** : crée "CORP-Baseline-Legal", édite →
*Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies →
Security Options* → "Interactive logon: Message text/title" → lie-la au domaine.

## Étape 2 — La même chose en PowerShell
```powershell
$gpo = New-GPO -Name "CORP-Baseline-Legal" -Comment "Bannière légale"
Set-GPRegistryValue -Name $gpo.DisplayName -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName legalnoticecaption -Type String -Value "Accès réservé"
Set-GPRegistryValue -Name $gpo.DisplayName -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName legalnoticetext -Type String -Value "Système CORP - accès autorisé uniquement."
New-GPLink -Name $gpo.DisplayName -Target "DC=corp,DC=meridian,DC=com"
```

## Étape 3 — Activer la baseline d'audit (prépare la détection, Phase 7)
```powershell
$audit = New-GPO -Name "CORP-Audit-Baseline"
# (En pratique : importer les Advanced Audit Policies ; ici on pose l'intention.)
New-GPLink -Name $audit.DisplayName -Target "OU=Servers,DC=corp,DC=meridian,DC=com" -ErrorAction SilentlyContinue
```

## Étape 4 — Filtrage de sécurité ciblé
```powershell
# N'appliquer une GPO qu'à un groupe précis (retirer Authenticated Users, ajouter le groupe)
$g = "CORP-Baseline-Legal"
Set-GPPermission -Name $g -TargetName "Authenticated Users" -TargetType Group -PermissionLevel None
Set-GPPermission -Name $g -TargetName "R_Finance_EMEA" -TargetType Group -PermissionLevel GpoApply
# (laisser au moins "Read" aux cibles pour l'application)
```

## Étape 5 — Vérifier l'application (RSoP)
```powershell
gpupdate /force          # sur un client cible
gpresult /h rsop.html    # rapport lisible ; ou Get-GPResultantSetOfPolicy
Get-GPResultantSetOfPolicy -User jon.snow -Computer PAR-WS-01 -ReportType Html -Path .\rsop.html
```

## Vérification
```powershell
Get-GPO -All | Select DisplayName, GpoStatus
Get-GPInheritance -Target "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com"
```

## Pièges courants
- Retirer *Authenticated Users* sans laisser de **Read** aux cibles → GPO qui ne s'applique pas.
- Trop de GPO/liens → lenteur de logon ; préférer peu de GPO bien structurées.
- Oublier que *Computer* vs *User* s'appliquent à des objets différents.
