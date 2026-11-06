# Automate — Sites & réplication
`Set-SitesTopology.ps1` crée sites, subnets, déplace les DC et crée les site links (idempotent).
`Get-ReplHealth.ps1` résume la santé de réplication (surveillance).
## Usage
```powershell
.\Set-SitesTopology.ps1   # édite le $topology dans le script selon architecture.md
.\Get-ReplHealth.ps1
```
