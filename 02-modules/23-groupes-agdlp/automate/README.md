# Automate — Groupes/AGDLP
`New-AgdlpAccess.ps1` crée la chaîne A→G→DL et pose la permission NTFS (P) pour une ressource,
de façon idempotente. `Get-GroupSprawl.ps1` rapporte les imbrications profondes / groupes vides.
## Usage
```powershell
.\New-AgdlpAccess.ps1 -Role "R_Finance_EMEA" -Resource "RES_FS-Finance_RW" -Member "jon.snow" `
  -Path "C:\Shares\Finance" -Rights Modify -GroupsOU "OU=Groups,DC=corp,DC=meridian,DC=com"
```
