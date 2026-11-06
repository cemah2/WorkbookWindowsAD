# Automate — LDAP
`Invoke-LdapAudit.ps1` exécute un jeu de requêtes de reconnaissance défensive (comptes à SPN,
sans pré-auth, membres de groupes sensibles) et exporte un rapport — utile pour auditer CORP.
## Usage
```powershell
.\Invoke-LdapAudit.ps1 -BaseDN "DC=corp,DC=meridian,DC=com" -OutFile ".\ldap-audit.csv"
```
