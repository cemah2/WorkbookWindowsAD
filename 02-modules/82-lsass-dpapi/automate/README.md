# Automate — LSASS/DPAPI
`Get-CredProtection.ps1` : audit de la posture (WDigest, RunAsPPL, Credential Guard). Lecture seule.
`Enable-CredProtection.ps1` : applique le durcissement (WDigest off, RunAsPPL). Tester avant prod.
## Usage
```powershell
.\Get-CredProtection.ps1
.\Enable-CredProtection.ps1      # redémarrage requis pour certains réglages
```
