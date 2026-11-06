# Defend — Durcir le déploiement AD CS

## Durcissement
1. **Ne pas exposer Web Enrollment en HTTP** ; si nécessaire : **HTTPS + EPA** (Extended Protection
   for Authentication) + désactiver NTLM → ferme **ESC8**.
2. **Signature requise** sur l'interface RPC d'enrôlement (anti **ESC11**).
3. **Signature SMB/LDAP** + **Protected Users** + réduction NTLM (modules 15/17) → coupe les relais.
4. **CA = Tier 0** (PAW, isolation VLAN 99) ; root hors-ligne.
5. **Audit AD CS** activé (`AuditFilter 127`) dès le déploiement.

## Détection
| Événement | Source | ID |
|---|---|---|
| Certificat émis | Security (AD CS audit) | 4886/4887 |
| Demande refusée | AD CS | 4888 |
| Changement de config CA | AD CS | 4890-4899 |
| Relais NTLM vers CA (ESC8) | corrélation NTLM + 4886 compte machine | — |

### Règle Sigma — émission d'un certificat à un compte machine/DC (indice ESC8)
```yaml
title: Certificat d'authentification émis pour un compte machine (possible ESC8)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4886
    Requester|endswith: '$'      # compte machine
  condition: selection
level: high
tags:
  - attack.credential_access
  - attack.t1649
```

## Preuve de détection (purple team)
Rejoue ESC8 en lab (PetitPotam + ntlmrelayx, module 43) et vérifie 4886 pour un compte machine +
la règle (P7). Puis désactive Web Enrollment HTTP et constate l'échec du relais.

## Rejouer contre CORP durci
Avec HTTPS+EPA (ou pas de Web Enrollment), signature RPC, NTLM réduit : ESC8/ESC11 échouent.
