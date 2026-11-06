# Automate — LAPS
`Set-LapsBaseline.ps1` étend le schéma (si besoin), pose les permissions self-write et read sur
une OU de machines, de façon idempotente. La politique (longueur/âge/chiffrement) se fait par GPO
(voir build.md) — scriptable en Phase 3 via l'ADMX LAPS / DSC.
## Usage
```powershell
.\Set-LapsBaseline.ps1 -ComputersOU "OU=Workstations,DC=corp,DC=meridian,DC=com" -ReadGroup "CORP\T2_Admins"
```
