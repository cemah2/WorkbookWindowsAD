# Automate — DSC
`BaseServer.ps1` : configuration DSC d'exemple (rôle + service + registre) réutilisable.
En Phase 3 (module 35), ces configs seront combinées pour reconstruire CORP. Conserver les MOF
hors dépôt s'ils contiennent des données sensibles (voir .gitignore).
## Usage
```powershell
. .\BaseServer.ps1          # charge la Configuration
BaseServer -OutputPath .\mof
Start-DscConfiguration -Path .\mof -Wait -Force
Test-DscConfiguration
```
