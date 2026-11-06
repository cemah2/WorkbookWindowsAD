# Automate — FSMO
`Get-FsmoRoles.ps1` affiche les 5 détenteurs. `Move-FsmoRoles.ps1` transfère (ou saisit avec -Seize)
tous les rôles vers un DC cible. ⚠️ -Seize uniquement si l'ancien détenteur est définitivement mort.
## Usage
```powershell
.\Get-FsmoRoles.ps1
.\Move-FsmoRoles.ps1 -TargetDC "PAR-DC-02"          # transfert propre
.\Move-FsmoRoles.ps1 -TargetDC "PAR-DC-02" -Seize   # saisie (DC mort uniquement)
```
