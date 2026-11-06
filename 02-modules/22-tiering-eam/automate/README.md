# Automate — Tiering
`New-TierStructure.ps1` crée les OU/groupes d'admin par tier de façon idempotente.
`Set-DenyLogonGpo.ps1` crée les 3 GPO de deny logon croisées (droits utilisateur) et les lie.
⚠️ Toujours disposer d'un accès break-glass avant d'appliquer les deny logon sur les DC.
## Usage
```powershell
.\New-TierStructure.ps1 -DomainDN "DC=corp,DC=meridian,DC=com"
.\Set-DenyLogonGpo.ps1  -DomainDN "DC=corp,DC=meridian,DC=com"
```
