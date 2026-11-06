# Drills — Coercition & relais

## Drill 1 — Liste des cibles relayables (10 min)
- **Étapes** : `nxc smb --gen-relay-list`.
- **Observer** : qui n'impose pas la signature SMB.
- **Pourquoi** : la signature est LA défense.

## Drill 2 — Coercition simple (10 min)
- **Étapes** : PetitPotam/PrinterBug vers l'attaquant (Responder en écoute).
- **Observer** : l'auth NTLM du compte machine arrive.
- **Pourquoi** : comprendre le déclencheur.

## Drill 3 — Relais LDAP → RBCD (15 min)
- **Étapes** : ntlmrelayx -t ldap --delegate-access + coercition → RBCD posée.
- **Pourquoi** : la chaîne escalade complète.

## Drill 4 — Relais AD CS (ESC8) (15 min)
- **Étapes** : ntlmrelayx --adcs + PetitPotam → certificat du DC.
- **Pourquoi** : le chemin PKI (lien module 43 + solution ESC8).

## Drill break-fix — Relais bloqué par la signature (10 min)
- **Casse** : active SMB/LDAP signing sur la cible.
- **Diagnostique** : ntlmrelayx signale "signing required".
- **Répare/comprends** : c'est la remédiation ; teste une cible non signée pour voir la différence.
