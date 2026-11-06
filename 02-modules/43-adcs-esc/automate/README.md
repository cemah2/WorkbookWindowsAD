# Automate — ESC
`Invoke-EscAudit.ps1` : wrapper défensif qui rappelle les commandes d'audit (Certipy/PSPKI/Locksmith)
et vérifie quelques réglages CA à risque (EDITF_ATTRIBUTESUBJECTALTNAME2, mapping). L'exploitation se
fait avec Certipy/Certify côté offensif (lab isolé). Ne jamais exécuter contre un domaine non autorisé.
## Usage
```powershell
.\Invoke-EscAudit.ps1
```
