# Automate — Préparation Windows Server

On reproduit `build.md` en script idempotent. `Set-ServerBaseline.ps1` renomme, adresse, règle l'heure
et active le remoting. En Phase 3, ce geste sera intégré à DSC/Ansible et déclenché à la
création de la VM (cloud-init / Ludus).

## Usage
```powershell
# À exécuter en administrateur sur la VM fraîchement installée. Adapter les paramètres.
.\Set-ServerBaseline.ps1 -NewName "PAR-DC-01" -IPAddress "10.10.0.10" -PrefixLength 16 `
                 -Gateway "10.10.0.1" -Dns "10.10.0.1" -TimeZone "Romance Standard Time"
```
Le script redémarre à la fin si le nom a changé.
