# Automate — Hybrid join / PRT
`Get-DeviceState.ps1` : récupère l'état des appareils côté Entra (TrustType/compliance). Côté poste,
`dsregcmd /status` reste l'outil de référence (interactif).
## Usage
```powershell
.\Get-DeviceState.ps1 -OutFile .\devices.csv
```
