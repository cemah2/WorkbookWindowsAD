# Drills — ESC AD CS (lab isolé)

## Drill 1 — Énumération Certipy (10 min)
- **Étapes** : `certipy find -vulnerable -stdout`.
- **Observer** : la liste des ESC détectés et pourquoi.
- **Pourquoi** : savoir cartographier la surface PKI (comme un auditeur).

## Drill 2 — ESC1 de bout en bout (15 min)
- **Étapes** : `certipy req ... -upn administrator@...` puis `certipy auth -pfx ...`.
- **Observer** : obtention d'un TGT administrateur via un certificat.
- **Pourquoi** : la chaîne la plus emblématique.

## Drill 3 — Réparer puis re-tester (10 min)
- **Étapes** : corrige le template (Build from AD), relance `certipy find -vulnerable`.
- **Observer** : l'ESC1 a disparu.
- **Pourquoi** : boucler attaque → remédiation → validation.

## Drill 4 — ESC8 (coercition + relais) (15 min)
- **Étapes** : `ntlmrelayx -t http://CA/certsrv/certfnsh.asp --adcs` + `PetitPotam` pour coercer un DC.
- **Observer** : certificat du DC obtenu → `certipy auth` → compromission.
- **Pourquoi** : comprendre le relais vers AD CS.

## Drill break-fix — Mapping fort casse une auth (10 min)
- **Casse** : active le mapping fort (KB5014754 full enforcement) avec un certificat à mapping faible.
- **Diagnostique** : l'auth par certificat échoue (mapping non conforme).
- **Répare** : réémettre le cert avec la security extension / mapping explicite fort.
