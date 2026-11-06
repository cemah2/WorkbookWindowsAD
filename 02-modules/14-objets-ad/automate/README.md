# Automate — Objets AD

`New-CorpObjects.ps1` crée une structure de départ (OU + quelques users + groupes AGDLP) de
façon idempotente, à partir d'un petit jeu de données. En Phase 3, la création en masse sera
pilotée par données (CSV/YAML) via PowerShell puis Ansible.

## Usage
```powershell
.\New-CorpObjects.ps1 -DomainDN "DC=corp,DC=meridian,DC=com"
```
