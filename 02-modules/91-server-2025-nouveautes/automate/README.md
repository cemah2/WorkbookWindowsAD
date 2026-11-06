# Automate — Server 2025 / dMSA
`Find-DmsaRisk.ps1` : repère les OU où des principaux non-privilégiés peuvent créer des dMSA (prérequis
BadSuccessor) et liste les dMSA + attributs de succession. Lecture seule, défensif.
## Usage
```powershell
.\Find-DmsaRisk.ps1 -BaseDN "DC=corp,DC=meridian,DC=com"
```
