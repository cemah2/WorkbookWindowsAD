# Automate — Déploiement AD CS
`Install-IssuingCA.ps1` installe le rôle + configure l'Issuing Enterprise Subordinate et active
l'audit. La Root (standalone/hors-ligne) et la signature du CSR restent manuelles (par sécurité).
## Usage
```powershell
.\Install-IssuingCA.ps1 -CommonName "Meridian Issuing CA"
```
