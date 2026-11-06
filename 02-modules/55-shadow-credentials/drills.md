# Drills — Shadow Credentials

## Drill 1 — Repérer AddKeyCredentialLink (10 min)
- **Étapes** : BloodHound → edges AddKeyCredentialLink vers des cibles.
- **Pourquoi** : identifier le vecteur par le graphe.

## Drill 2 — certipy shadow auto (15 min)
- **Étapes** : exécute la chaîne complète sur une cible de lab.
- **Observer** : NT hash obtenu sans mot de passe initial de la cible.
- **Pourquoi** : la puissance de l'attribut.

## Drill 3 — Lire msDS-KeyCredentialLink (10 min)
- **Étapes** : avant/après, inspecte l'attribut (ldapsearch / Get-ADObject).
- **Pourquoi** : comprendre ce qui est écrit, et le nettoyage.

## Drill break-fix — PKINIT indisponible (10 min)
- **Casse** : pas de clé NTAuth / Key Trust → la chaîne échoue.
- **Diagnostique** : erreur PKINIT.
- **Répare/comprends** : prérequis PKI ; vérifie NTAuthCertificates (module 40).
