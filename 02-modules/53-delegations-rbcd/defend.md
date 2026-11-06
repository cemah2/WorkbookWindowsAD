# Defend — Maîtriser les délégations

## Durcissement
1. **Éliminer l'unconstrained delegation** (sauf nécessité absolue) ; marquer les comptes sensibles
   « **Account is sensitive and cannot be delegated** » + **Protected Users**.
2. **`ms-DS-MachineAccountQuota = 0`** (empêche un user de créer des comptes machine → casse une
   voie RBCD courante).
3. **ACL strictes** sur les objets machine (pas de GenericWrite pour des non-admins) — module 21.
4. **Constrained delegation** cadrée (SPN minimaux, pas de protocol transition inutile).
5. Surveiller les écritures de `msDS-AllowedToActOnBehalfOfOtherIdentity`.

## Détection
| Événement | Signal | ID |
|---|---|---|
| Écriture RBCD | modif `msDS-AllowedToActOnBehalfOfOtherIdentity` | 5136 |
| Création de compte machine | addcomputer | 4741 |
| S4U anormal | tickets S4U2Self/Proxy | 4769 |

### Règle Sigma — écriture de l'attribut RBCD
```yaml
title: Écriture de msDS-AllowedToActOnBehalfOfOtherIdentity (RBCD)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    AttributeLDAPDisplayName: 'msDS-AllowedToActOnBehalfOfOtherIdentity'
  condition: selection
level: high
tags:
  - attack.privilege_escalation
  - attack.t1098
```

## Preuve de détection (purple team)
Rejoue la chaîne RBCD et vérifie 4741 (compte machine) + 5136 (attribut RBCD) + la règle (P7).

## Rejouer contre CORP durci
Avec MachineAccountQuota=0, ACL propres, pas d'unconstrained et Protected Users : RBCD et
unconstrained+coercition échouent.
