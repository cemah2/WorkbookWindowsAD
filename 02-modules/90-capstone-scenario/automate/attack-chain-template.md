# Chaîne d'attaque — capstone <date>

| # | Étape | Technique ATT&CK | Commande/outil | Résultat | Détecté ? (règle) | Remédiation |
|---|---|---|---|---|---|---|
| 1 | Recon | T1087 | bloodhound-python | chemin X | 1644 | LDAP signing |
| 2 | Kerberoasting | T1558.003 | GetUserSPNs | mdp svc | 4769 RC4 | AES/gMSA |
| 3 | ... | ... | ... | ... | ... | ... |

## Schéma du chemin
<recon -> escalade -> dominance -> persistance (+ hybride/cross-forest)>

## Résultat global
<Domain Admin obtenu ? via quel chemin le plus court ? temps ?>
