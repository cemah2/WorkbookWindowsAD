# Defend — Du chemin d'attaque aux détections

## Principe (purple team)
La méthodologie défensive miroir : pour chaque étape offensive, identifier la **data source** et la
**détection**. Le workbook relie systématiquement attaque ↔ détection.

## Cartographie attaque → détection (synthèse)
| Étape | Détection clé | Module |
|---|---|---|
| Recon LDAP/BloodHound | requêtes LDAP massives (1644), 4662 | 15, 51 |
| Kerberoasting | 4769 RC4 en volume | 16, 52 |
| Abus d'ACL | 5136 (nTSecurityDescriptor), 4724 | 21 |
| ESC (certificats) | 4886/5136 | 43 |
| Coercition/relais | MS-EFSRPC + 4886/NTLM | 54 |
| Dump creds | accès LSASS, 4662 DCSync | 56, 26 |
| Persistance | 4768/4769 anormaux, 5136 | 57 |

## Reporting défensif
Le journal de bord offensif devient la **liste des détections à valider** : chaque action doit
idéalement déclencher une alerte. Les trous = angles morts à couvrir (Phase 7).

## Preuve (purple team)
Rejouer le fil rouge et cocher, étape par étape, quelles détections se déclenchent (SIEM, Phase 7).

## Rejouer contre CORP durci
Le même fil rouge contre CORP (tiering, LAPS, ESC corrigés, NTLM réduit) doit échouer à plusieurs
étapes — c'est la démonstration de l'efficacité des phases 2-4.
