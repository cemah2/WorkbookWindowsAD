# Automate — Entra fondamentaux
`Connect-Lab.ps1` : connexion Graph avec les scopes de lab. `Get-TenantInventory.ps1` : inventaire
(users, rôles, apps, SP) — base d'audit. Secrets/tokens jamais committés.
## Usage
```powershell
.\Connect-Lab.ps1
.\Get-TenantInventory.ps1 -OutFile .\tenant-inventory.json
```
