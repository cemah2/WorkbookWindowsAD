# Build — Gérer et transférer les FSMO (dans CORP)

## Pré-requis
- Au moins 2 DC (PAR-DC-01, PAR-DC-02 ou NYC-DC-01).

## Étape 1 — Localiser les rôles
```powershell
netdom query fsmo
Get-ADForest | Select SchemaMaster, DomainNamingMaster
Get-ADDomain | Select PDCEmulator, RIDMaster, InfrastructureMaster
```

## Étape 2 — Transfert propre d'un rôle
```powershell
# Déplacer le PDC Emulator vers PAR-DC-02 (transfert, les 2 DC en ligne)
Move-ADDirectoryServerOperationMasterRole -Identity "PAR-DC-02" -OperationMasterRole PDCEmulator
# Plusieurs à la fois :
Move-ADDirectoryServerOperationMasterRole -Identity "PAR-DC-02" `
  -OperationMasterRole RIDMaster, InfrastructureMaster
```

## Étape 3 — Vérifier le temps (PDC Emulator)
```powershell
# Le PDC doit être la source NTP de référence
w32tm /query /status
w32tm /query /configuration
```

## Étape 4 — Simuler une saisie (seizure) — en lab, sur DC "mort"
```powershell
# UNIQUEMENT si le détenteur est DÉFINITIVEMENT hors service (ne jamais le rallumer ensuite)
Move-ADDirectoryServerOperationMasterRole -Identity "PAR-DC-02" `
  -OperationMasterRole SchemaMaster -Force
# Puis metadata cleanup de l'ancien DC (ntdsutil) — voir module 29.
```

## Vérification
```powershell
netdom query fsmo   # les rôles pointent vers les bons DC
```

## Pièges courants
- **Saisir** un rôle puis **rallumer** l'ancien détenteur → duplication/corruption.
- Oublier le **metadata cleanup** après une saisie.
- Mauvais placement de l'Infrastructure Master en multi-domaines.
