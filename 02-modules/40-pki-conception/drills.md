# Drills — Conception PKI

## Drill 1 — Lire une chaîne de certificats (10 min)
- **Étapes** : sur un certificat existant (ex. LDAPS si présent), examine la chaîne
  (`certutil -verify`, ou MMC Certificates). Identifie root/intermédiaire/feuille.
- **Pourquoi** : comprendre la hiérarchie par l'exemple.

## Drill 2 — CDP/AIA d'un certificat (10 min)
- **Étapes** : `certutil -url <cert>` ou examine les extensions CDP/AIA d'un certificat.
- **Observer** : où la révocation/les certificats d'autorité sont publiés.
- **Pourquoi** : la révocation ne marche que si ces points sont joignables.

## Drill 3 — NTAuthCertificates (10 min)
- **Étapes** : `certutil -viewstore "ldap:///CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=corp,DC=meridian,DC=com"`.
- **Observer** : quelles CA peuvent émettre des certificats d'authentification.
- **Pourquoi** : c'est un point de confiance critique (abus = auth en tant que n'importe qui).

## Drill 4 — Rédiger la conception (15 min)
- **Étapes** : remplis un mini-document (hiérarchie, usages, durées, révocation).
- **Pourquoi** : forcer les décisions avant de déployer.
