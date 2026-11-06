# Automate — Sauvegarde & PRA
`Backup-ADSystemState.ps1` lance une sauvegarde system state et vérifie les versions.
`Enable-RecycleBin.ps1` active l'AD Recycle Bin (idempotent). La restauration reste une procédure
manuelle guidée (voir build.md) par prudence.
## Usage
```powershell
.\Enable-RecycleBin.ps1 -ForestDN "meridian.com"
.\Backup-ADSystemState.ps1 -Target "E:"
```
