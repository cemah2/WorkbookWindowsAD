# Build — Déployer la PKI 2 niveaux (dans CORP)

> On suit la conception du module 40. Root CA **hors-ligne** (standalone), Issuing CA **Enterprise**.

## Pré-requis
- 2 VM : `ROOT-CA` (non jointe au domaine, isolée) et `PAR-CA-01` (jointe, Tier 0, VLAN 99).
- CAPolicy.inf placés (module 40) dans `C:\Windows\` sur chaque CA.

## Étape 1 — Root CA (standalone, hors-ligne)
```powershell
# Sur ROOT-CA (hors domaine)
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools
Install-AdcsCertificationAuthority -CAType StandaloneRootCA `
  -CACommonName "Meridian Root CA" -KeyLength 4096 -HashAlgorithmName SHA256 `
  -ValidityPeriod Years -ValidityPeriodUnits 15 -Force
# Configurer CDP/AIA HTTP (pki.corp.meridian.com) via certutil, publier la CRL
certutil -crl
```

## Étape 2 — Récupérer la CRL/cert de la root et les publier dans AD
```powershell
# Copier le cert root + CRL vers un DC, puis publier dans AD (depuis un compte Enterprise Admin)
certutil -dspublish -f "MeridianRootCA.crt" RootCA
certutil -addstore -f Root "MeridianRootCA.crt"
certutil -f -dspublish "MeridianRootCA.crl"
```

## Étape 3 — Issuing CA (Enterprise Subordinate)
```powershell
# Sur PAR-CA-01 (joint au domaine)
Install-WindowsFeature ADCS-Cert-Authority, ADCS-Web-Enrollment -IncludeManagementTools
Install-AdcsCertificationAuthority -CAType EnterpriseSubordinateCA `
  -CACommonName "Meridian Issuing CA" -KeyLength 4096 -HashAlgorithmName SHA256 -Force
# -> génère une demande (CSR) à faire signer par la Root
```

## Étape 4 — Signer la sub par la root (transfert manuel, root hors-ligne)
```powershell
# Transférer le CSR vers ROOT-CA, le signer :
certreq -submit "PAR-CA-01.req"          # sur ROOT-CA -> RequestId
certutil -resubmit <RequestId>           # approuver si standalone demande approbation
certreq -retrieve <RequestId> "PAR-CA-01.crt"
# Puis installer le certificat signé sur l'Issuing CA :
certutil -installcert "PAR-CA-01.crt"
Start-Service certsvc
```

## Étape 5 — Révocation & audit
```powershell
# Audit AD CS (toutes catégories)
certutil -setreg CA\AuditFilter 127
Restart-Service certsvc
# Vérifier CDP/AIA
certutil -getreg CA\CRLPublicationURLs
```

## Étape 6 — Éteindre la Root CA
Une fois l'Issuing opérationnelle, **éteindre/déconnecter** la Root CA (la rallumer seulement pour
re-publier la CRL).

## Vérification
```powershell
certutil -ping -config "PAR-CA-01\Meridian Issuing CA"
certutil -verify -urlfetch <un_certificat_emis>     # chaîne + révocation OK
Get-CACrlDistributionPoint ; Get-CAAuthorityInformationAccess
```

## Pièges courants
- Laisser la Root CA en ligne / jointe au domaine.
- CDP/AIA inaccessibles → `certutil -verify` échoue (chaîne/révocation).
- Oublier d'activer l'audit AD CS (indispensable pour la détection des ESC).
