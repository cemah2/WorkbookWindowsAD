# Automate — RODC
`Set-RodcPrp.ps1` applique une PRP sûre (autorise un groupe d'agence, garde les sensibles en Denied)
et rapporte les comptes révélés. La promotion elle-même est manuelle/scriptée (voir build.md).
## Usage
```powershell
.\Set-RodcPrp.ps1 -Rodc "LYO-RODC-01" -AllowedGroup "R_Lyon_Users"
```
