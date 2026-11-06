# Automate — Kerberos (observation/audit)
`Get-KerberosHealth.ps1` collecte un état défensif : comptes RC4-only, comptes à SPN,
comptes sans pré-auth, et un extrait des 4768/4769/4771. Lecture seule.
## Usage
```powershell
.\Get-KerberosHealth.ps1 -BaseDN "DC=corp,DC=meridian,DC=com"
```
