# Defend — Détecter et gêner la reconnaissance

## Durcissement
1. **Signature/anonyme LDAP** (module 15), limiter la lecture d'attributs sensibles si possible.
2. **Réduire la surface** : moins d'SPN inutiles, pas de no-preauth, ACL propres (modules 16/21/23).
3. **Honeytokens** : comptes/objets leurres qui alertent dès qu'on les touche.
4. **Segmenter** (un compte T2 ne doit pas tout voir du Tier 0).

## Détection
| Événement | Source | Signal |
|---|---|---|
| Requêtes LDAP massives/inefficaces | Directory Service | 1644 (audit) |
| Collecte type BloodHound | SIEM | pic de requêtes LDAP + sessions |
| User enum Kerberos (Kerbrute) | Security | 4768/4771 en rafale |
| Énumération SAMR | Security | 4661/4662 |

### Règle Sigma — énumération Kerberos (4768 refusés en rafale)
```yaml
title: Énumération d'utilisateurs Kerberos (Kerbrute)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4768
    ResultCode: '0x6'      # principal inconnu
  timeframe: 1m
  condition: selection | count() by IpAddress > 20
level: medium
tags:
  - attack.discovery
  - attack.t1087
```

## Preuve de détection (purple team)
Lance `kerbrute userenum` et une collecte BloodHound, vérifie 4768/4771 + 1644 et le déclenchement
des règles (P7). Pose un honeytoken et confirme l'alerte quand il est énuméré.

## Rejouer contre CORP durci
LDAP signé + attributs réduits + honeytokens : la recon est plus bruyante et plus pauvre, et déclenche
des alertes précoces.
