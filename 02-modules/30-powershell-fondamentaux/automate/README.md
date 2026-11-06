# Automate — PowerShell fondamentaux
`New-CorpUser.ps1` : fonction idempotente de création d'utilisateur (SecureString, -WhatIf).
`Tests/New-CorpUser.Tests.ps1` : squelette Pester. Ces patterns servent de base à tous les scripts
du workbook.
## Usage
```powershell
.\New-CorpUser.ps1 -Sam "test.user" -DisplayName "Test User" -OU "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com" -WhatIf
```
