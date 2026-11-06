# Automate — DFS
`New-DfsShare.ps1` crée partage + entrée de namespace de façon idempotente.
`Get-DfsrHealth.ps1` rapporte l'état/backlog de réplication (surveillance).
## Usage
```powershell
.\New-DfsShare.ps1 -Server "PAR-FS-01" -ShareName "Finance" -LocalPath "C:\Shares\Finance" `
  -Namespace "\\corp.meridian.com\shares" -RwGroup "CORP\RES_FS-Finance_RW" -RoGroup "CORP\RES_FS-Finance_RO"
```
