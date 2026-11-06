# Build — Migrer CORP vers 2025 & étudier dMSA (lab isolé)

## Pré-requis
- Une **copie jetable** de CORP (snapshot), au moins un DC Windows Server 2025. Lab isolé pour la
  partie BadSuccessor.

## Étape 1 — Ajouter un DC Server 2025 & élever le niveau fonctionnel
```powershell
# Après avoir promu un DC 2025 et vérifié la réplication :
Get-ADForest | Select ForestMode
Get-ADDomain | Select DomainMode
# Élever (copie jetable uniquement) :
Set-ADForestMode -Identity corp.meridian.com -ForestMode Windows2025Forest -WhatIf
Set-ADDomainMode -Identity corp.meridian.com -DomainMode Windows2025Domain -WhatIf
```
(Retirer `-WhatIf` une fois sûr ; irréversible — d'où la copie jetable.)

## Étape 2 — Créer un dMSA (usage légitime)
```powershell
# Créer un dMSA et (optionnel) le lier comme successeur d'un ancien compte de service
New-ADServiceAccount -Name "dmsa-app01" -DNSHostName "app01.corp.meridian.com" `
  -KerberosEncryptionType AES256 -Enabled $true
# (la configuration de succession se fait via les attributs/outils dMSA)
```

## Étape 3 — Observer la nouvelle surface (dMSA)
```powershell
Get-ADServiceAccount -Filter * -Properties msDS-DelegatedMSAState, msDS-ManagedAccountPrecededByLink |
  Select Name, 'msDS-DelegatedMSAState', 'msDS-ManagedAccountPrecededByLink'
```

## Étape 4 — BadSuccessor (compréhension + détection, lab isolé)
- Identifier qui a le droit de **créer** des dMSA / d'écrire leurs attributs de succession sur des OU
  (ACL — module 21). C'est le prérequis de l'attaque.
- (En lab isolé) comprendre comment la désignation d'un dMSA comme successeur d'un compte privilégié
  mène à l'escalade — puis **réparer** l'ACL et vérifier que ce n'est plus possible.

## Étape 5 — Comparer la surface NTLM
- Avec 2025 : tester la réduction NTLM (IAKerb/Local KDC) ; auditer l'usage NTLM résiduel (module 17).

## Vérification
```powershell
Get-ADDomain | Select DomainMode           # Windows2025Domain (sur la copie)
Get-ADServiceAccount -Filter * | Select Name   # dMSA présents
```

## Pièges courants
- Élever le niveau fonctionnel sur la **vraie** CORP (irréversible) → toujours une copie jetable.
- Laisser des droits de création de dMSA trop larges sur des OU (= BadSuccessor).
