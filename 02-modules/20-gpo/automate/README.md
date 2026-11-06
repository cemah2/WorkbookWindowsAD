# Automate — GPO
`New-BaselineGpo.ps1` crée une GPO de base (bannière légale + statut) de façon idempotente et la
lie au domaine. En Phase 3, l'import des **Microsoft Security Baselines** et le backup/restore de
GPO (`Backup-GPO`/`Import-GPO`) seront intégrés à l'IaC.
## Usage
```powershell
.\New-BaselineGpo.ps1 -DomainDN "DC=corp,DC=meridian,DC=com"
```
