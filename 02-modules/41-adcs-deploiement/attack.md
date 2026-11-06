# Attack — Cibler le service AD CS

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Détail des ESC au module 43 ; ici, les vecteurs liés au
> **déploiement/exposition** du service.

## Techniques
- **MITRE ATT&CK** : T1649 (Steal or Forge Authentication Certificates).
- **Vecteurs liés au service** :
  - **ESC8** : `CA Web Enrollment` (HTTP) + **relais NTLM** d'un compte machine/DC → certificat
    d'authentification de ce compte → compromission.
  - **ESC11** : interface RPC d'enrôlement sans signature (relais).
  - CA en ligne mal protégée (Tier 0) = cible directe.

## Déroulé (principe, module 43 pour l'outillage)
1. Repérer l'endpoint Web Enrollment (`http://PAR-CA-01/certsrv/`).
2. Coercer un compte machine (PetitPotam/Coercer) et **relayer** son auth NTLM vers l'endpoint HTTP
   (`ntlmrelayx ... -t http://CA/certsrv/certfnsh.asp`) → obtenir un certificat du DC.
3. S'authentifier avec ce certificat (PKINIT) en tant que le DC.

## Ancrage réel
ESC8 (PetitPotam + relais vers AD CS) est l'une des chaînes les plus connues menant à la
compromission de domaine. Omniprésente en audit depuis 2021.

## Résultat attendu
Comprendre que le mode d'exposition (Web Enrollment HTTP, signature) crée ou ferme ESC8/ESC11.
