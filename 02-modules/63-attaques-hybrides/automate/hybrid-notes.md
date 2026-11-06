# Attaques hybrides — aide-mémoire (tenant de TEST + lab isolé uniquement)

## On-prem -> cloud
# Entra Connect (lab) :
Import-Module AADInternals ; Get-AADIntSyncCredentials
# AZUREADSSOACC$ -> ticket cloud (AADInternals)
# ADFS -> Golden SAML (si clé de signature volée)

## Poste HAADJ -> cloud
# Pass-the-PRT : ROADtools/roadtx, TokenTactics (si TPM absent)
roadtx browserprtauth

## Cloud pur
# Illicit consent grant : app + scopes Graph -> refresh token
# Service principal abuse : add secret/cert -> persistance
# Device code phishing : flux device-code -> tokens

## Cloud -> on-prem
# Intune : push script/app sur machines gérées
# Password writeback : reset on-prem depuis le cloud

## Rappel : TENANT DE TEST uniquement. Toujours re-durcir (module 64) et nettoyer.
