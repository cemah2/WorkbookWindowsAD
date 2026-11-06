# Attack — Aperçu des attaques NTLM

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Introduction ; l'exploitation détaillée (Responder,
> ntlmrelayx, PtH) est en Phase 5 (modules 54, 56).

## Panorama
| Attaque | Principe | MITRE |
|---|---|---|
| **Pass-the-Hash** | Le hash NT suffit à s'authentifier | T1550.002 |
| **Capture NetNTLMv2** | Empoisonnement LLMNR/NBT-NS (Responder), cassage hors-ligne | T1557.001 / T1110 |
| **Relais NTLM** | Relayer l'auth vers SMB/LDAP/AD CS (si non signé) | T1557.001 |
| **Downgrade** | Forcer NTLM là où Kerberos serait possible | T1562 |

## Démonstration minimale (observation)
Vérifier l'absence de signature SMB (prérequis d'un relais) :
```bash
netexec smb 10.10.0.10          # regarde "signing:False/True"
```
> Le relais lui-même (ntlmrelayx) et la capture (Responder) sont joués en Phase 5 dans GOAD-X.

## Ancrage réel
Les relais NTLM (ex. vers AD CS = ESC8, ou création de RBCD) et Pass-the-Hash figurent parmi les
techniques les plus utilisées en intrusion Windows depuis plus d'une décennie — raison de la
dépréciation de NTLM en 2025.

## Résultat attendu
Comprendre pourquoi NTLM non signé est un risque majeur — fermé par `defend.md`.
