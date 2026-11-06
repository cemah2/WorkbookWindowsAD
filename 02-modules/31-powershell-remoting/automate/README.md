# Automate — Remoting
`Invoke-OnFleet.ps1` exécute un scriptblock sur une liste de machines (fan-out, throttle, gestion
d'erreurs, résultats structurés). Base des opérations de parc du workbook.
## Usage
```powershell
.\Invoke-OnFleet.ps1 -Computers (Get-ADComputer -Filter * -SearchBase "OU=Tier1,OU=Servers,DC=corp,DC=meridian,DC=com").DNSHostName `
  -Script { Get-HotFix | Sort InstalledOn -Descending | Select -First 1 }
```
