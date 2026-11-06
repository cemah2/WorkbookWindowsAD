# Build — Créer et publier des templates sûrs (dans CORP)

> On crée des templates **bien configurés** pour les usages de CORP (TLS serveur, authentification
> utilisateur par smartcard, etc.), en évitant les pièges ESC.

## Pré-requis
- Issuing CA opérationnelle (module 41). Module `PSPKI` utile (`Install-Module PSPKI`).

## Étape 1 — Dupliquer un template de base (jamais éditer les défauts)
Dans **certtmpl.msc** : dupliquer "Web Server" → "CORP-WebServer".
- *Subject Name* = **Build from AD** (pas ESS).
- *Security* : Enroll pour un groupe précis (ex. `RES_WebServers_Enroll`), pas "Authenticated Users".

## Étape 2 — Template d'authentification utilisateur (prudent)
Dupliquer "User" → "CORP-UserAuth" :
- EKU = Client Authentication (nécessaire pour l'auth) **mais** Subject = Build from AD (anti ESC1).
- *Manager approval* ou *authorized signature* si l'usage le permet (atténuation).
- Enroll limité à un groupe ; pas d'auto-enroll non maîtrisé.

## Étape 3 — Publier le template sur la CA
```powershell
# Via PSPKI
Import-Module PSPKI
Get-CertificateTemplate -Name "CORP-WebServer" | Set-CertificateTemplateAcl ...   # ACL ciblée
# Publier (rendre émsettable par l'Issuing CA)
Add-CATemplate -Name "CORP-WebServer"
```
(ou via certsrv.msc → New → Certificate Template to Issue)

## Étape 4 — Auto-enrollment maîtrisé (GPO)
GPO : *Computer/User Configuration → Policies → Windows Settings → Security Settings → Public Key
Policies → Certificate Services Client - Auto-Enrollment* = Enabled, pour les groupes voulus.

## Étape 5 — Demander un certificat (test)
```powershell
Get-Certificate -Template "CORP-WebServer" -CertStoreLocation Cert:\LocalMachine\My -SubjectName "CN=par-fs-01.corp.meridian.com"
# ou certreq / MMC Certificates
```

## Étape 6 — Auditer les templates (anti-ESC)
```powershell
# Avec Certipy (depuis l'attaquant Linux, lecture) ou PSPKI :
# certipy find -u jon.snow@corp.meridian.com -p '***' -dc-ip 10.10.0.10 -vulnerable
Get-CertificateTemplate | Select Name, @{n='ESS';e={$_.EnrolleeSuppliesSubject}}, @{n='EKU';e={$_.ExtendedKeyUsage}}
```

## Vérification
- Chaque template a une EKU justifiée, un Subject *Build from AD* (sauf besoin explicite), des
  permissions d'Enroll **ciblées**, et pas de combinaison ESC1 (ESS + auth + enroll large).

## Pièges courants
- Éditer les templates par défaut (toujours dupliquer).
- Laisser "Authenticated Users" en Enroll sur un template d'auth avec ESS = **ESC1**.
- Donner Write sur un template à un groupe large = **ESC4**.
