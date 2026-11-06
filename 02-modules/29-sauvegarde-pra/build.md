# Build — Sauvegarder et restaurer AD (dans CORP)

## Pré-requis
- ≥ 2 DC. Windows Server Backup installable ; PBS disponible (module Phase 0).

## Étape 1 — Activer l'AD Recycle Bin (irréversible, recommandé)
```powershell
Enable-ADOptionalFeature "Recycle Bin Feature" -Scope ForestOrConfigurationSet `
  -Target "meridian.com"
```

## Étape 2 — Installer et lancer une sauvegarde System State
```powershell
Install-WindowsFeature Windows-Server-Backup
# Sauvegarde system state vers un volume dédié (ex. E:)
wbadmin start systemstatebackup -backupTarget:E: -quiet
```
En parallèle : sauvegarde **niveau VM** du DC via **Proxmox Backup Server** (snapshots/jobs).

## Étape 3 — Restaurer un objet supprimé (Recycle Bin)
```powershell
# Retrouver puis restaurer un objet supprimé (sans DSRM)
Get-ADObject -Filter 'isDeleted -eq $true -and Name -like "*Jon*"' -IncludeDeletedObjects
Get-ADObject -Filter 'samAccountName -eq "jon.snow"' -IncludeDeletedObjects |
  Restore-ADObject
```

## Étape 4 — Restauration autoritaire d'une OU (ntdsutil) — lab
```
:: Démarrer le DC en DSRM, puis :
ntdsutil
  activate instance ntds
  authoritative restore
    restore subtree "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com"
  quit
quit
```

## Étape 5 — Remettre un DC mort (non autoritaire) + metadata cleanup
```powershell
# Si le DC est irrécupérable : nettoyer ses métadonnées
# (ntdsutil metadata cleanup, ou :)
Remove-ADDomainController -Identity "DEAD-DC" -ForceRemoval  # sur le DC si accessible
# Sinon : ntdsutil -> metadata cleanup -> remove selected server
```

## Étape 6 — TESTER la restauration (indispensable)
Restaure réellement une VM DC depuis PBS dans un réseau isolé et vérifie `dcdiag`/`repadmin`.
Une sauvegarde jamais testée n'est pas une sauvegarde.

## Vérification
```powershell
(Get-ADOptionalFeature "Recycle Bin Feature").EnabledScopes   # Recycle Bin active
wbadmin get versions                                          # sauvegardes présentes
```

## Pièges courants
- Rétention > tombstone lifetime (restaurer une sauvegarde trop vieille corrompt la réplication).
- Ne jamais **tester** les restaurations.
- Rallumer un DC saisi/mort après metadata cleanup.
