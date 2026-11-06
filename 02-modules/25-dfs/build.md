# Build — Mettre en place DFS-N + DFS-R (dans CORP)

## Pré-requis
- Au moins un serveur de fichiers (ex. `PAR-FS-01`). Pour la réplication : un second (ex. `NYC-FS-01`).
- AGDLP en place (module 23) pour les permissions.

## Étape 1 — Installer les rôles
```powershell
Install-WindowsFeature FS-DFS-Namespace, FS-DFS-Replication, RSAT-DFS-Mgmt-Con -IncludeManagementTools
```

## Étape 2 — Créer un partage + ACL (AGDLP)
```powershell
New-Item -Path "C:\Shares\Finance" -ItemType Directory -Force | Out-Null
New-SmbShare -Name "Finance" -Path "C:\Shares\Finance" -FullAccess "CORP\Domain Admins" `
  -ChangeAccess "CORP\RES_FS-Finance_RW" -ReadAccess "CORP\RES_FS-Finance_RO"
# ACL NTFS via le groupe ressource (voir module 23)
```

## Étape 3 — Créer le namespace domain-based
```powershell
New-DfsnRoot -TargetPath "\\PAR-FS-01\Shares" -Type DomainV2 -Path "\\corp.meridian.com\shares"
# Ajouter un dossier dans le namespace pointant vers le partage Finance
New-DfsnFolder -Path "\\corp.meridian.com\shares\Finance" -TargetPath "\\PAR-FS-01\Finance"
```

## Étape 4 — Réplication DFS-R entre deux serveurs
```powershell
New-DfsReplicationGroup -GroupName "RG-Finance"
Add-DfsrMember -GroupName "RG-Finance" -ComputerName "PAR-FS-01","NYC-FS-01"
New-DfsReplicatedFolder -GroupName "RG-Finance" -FolderName "Finance"
# Connexion (topologie) + appartenances (primary member au départ)
Add-DfsrConnection -GroupName "RG-Finance" -SourceComputerName "PAR-FS-01" -DestinationComputerName "NYC-FS-01"
Set-DfsrMembership -GroupName "RG-Finance" -FolderName "Finance" -ComputerName "PAR-FS-01" `
  -ContentPath "C:\Shares\Finance" -PrimaryMember $true -Force
Set-DfsrMembership -GroupName "RG-Finance" -FolderName "Finance" -ComputerName "NYC-FS-01" `
  -ContentPath "C:\Shares\Finance" -Force
# Ajouter la 2e cible de dossier dans le namespace (pour la localité par site)
New-DfsnFolderTarget -Path "\\corp.meridian.com\shares\Finance" -TargetPath "\\NYC-FS-01\Finance"
```

## Étape 5 — Vérifier
```powershell
Get-DfsnFolderTarget -Path "\\corp.meridian.com\shares\Finance"
Get-DfsrState -ComputerName "PAR-FS-01"            # état de réplication
Get-DfsrBacklog -GroupName "RG-Finance" -FolderName "Finance" `
  -SourceComputerName "PAR-FS-01" -DestinationComputerName "NYC-FS-01"
```
Teste : crée un fichier sur PAR-FS-01 → il apparaît sur NYC-FS-01 ; un client est dirigé vers la
cible de son site.

## Pièges courants
- Partage **Everyone/Full** (utiliser AGDLP).
- Staging sous-dimensionné pour gros fichiers → réplication lente.
- Oublier que DFS-N ne protège pas : ce sont les **ACL NTFS** qui comptent.
