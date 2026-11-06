# Defend — Contrer BadSuccessor & sécuriser 2025

## Durcissement
1. **Restreindre la création de dMSA** : auditer/limiter le droit CreateChild pour la classe
   `msDS-DelegatedManagedServiceAccount` sur les OU ; traiter ce droit comme **Tier 0**.
2. **ACL propres** sur les OU (pas de GenericAll/WriteDacl pour des non-admins) — module 21.
3. **Surveiller** les attributs de succession (`msDS-ManagedAccountPrecededByLink`, `msDS-DelegatedMSAState`).
4. **Correctifs** Microsoft et suivi de la recherche (BadSuccessor).
5. Profiter de 2025 pour **réduire NTLM** (IAKerb/Local KDC) et renforcer LDAP channel binding.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Création d'un dMSA | Security | 4741/5137 (objet dMSA) |
| Écriture lien de succession | Security | 5136 (msDS-ManagedAccountPrecededByLink) |
| Authentification dMSA inhabituelle | Security | 4768/4769 pour le dMSA |

### Règle Sigma — écriture du lien de succession dMSA (BadSuccessor)
```yaml
title: Écriture de msDS-ManagedAccountPrecededByLink (possible BadSuccessor)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    AttributeLDAPDisplayName: 'msDS-ManagedAccountPrecededByLink'
  condition: selection
level: high
tags:
  - attack.privilege_escalation
  - attack.t1098
```

## Preuve de détection (purple team)
En lab 2025, configure un dMSA avec un lien de succession et vérifie 5137/5136 + la règle (module 74).
Puis restreins l'ACL et confirme que la création/écriture n'est plus possible pour un non-admin.

## Rejouer contre CORP durci
Avec création de dMSA réservée au Tier 0 + ACL propres + surveillance des attributs, BadSuccessor n'est
plus exploitable et toute tentative est détectée.
