# Automate — Délégation
`Set-OuDelegation.ps1` applique une délégation "Reset Password" ciblée sur une OU à un groupe,
de façon idempotente (via dsacls). `Get-AclReport.ps1` exporte les ACE non héritées pour audit.
## Usage
```powershell
.\Set-OuDelegation.ps1 -OuDN "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com" -Group "CORP\T2_EMEA_Support"
.\Get-AclReport.ps1 -SearchBase "DC=corp,DC=meridian,DC=com" -OutFile ".\acl-report.csv"
```
