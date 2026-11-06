# Defend — Durcir et surveiller LDAP

## Durcissement
1. **Exiger la signature LDAP + channel binding** (GPO Domain Controllers) — bloque le relais NTLM→LDAP.
2. **Désactiver les binds anonymes** (vérifier `dsHeuristics`).
3. **LDAPS** avec certificat valide (PKI, Phase 4).
4. **Limiter la lecture** d'attributs très sensibles si possible (ex. restreindre certaines ACL).
5. Surveiller les **collectes massives** (signature BloodHound).

## Détection
| Événement | Source | ID |
|---|---|---|
| Requête LDAP coûteuse/inefficace | Directory Service | 1644 (si audit activé) |
| Bind non sécurisé détecté | Directory Service | 2886/2887/2889 (signalement signature) |
| Volume anormal de requêtes | SIEM (corrélation) | — |

### Règle Sigma — binds LDAP non signés signalés par le DC
```yaml
title: Binds LDAP non signés détectés sur un DC
logsource:
  product: windows
  service: application
detection:
  selection:
    Provider_Name: 'Microsoft-Windows-ActiveDirectory_DomainService'
    EventID: 2889
  condition: selection
level: medium
tags:
  - attack.credential_access
  - attack.t1557.001
```

## Preuve de détection (purple team)
Active l'audit des binds (2889), génère un bind non signé, vérifie l'événement puis la règle (P7).
Lance une collecte SharpHound et observe le pic de requêtes 1644.

## Rejouer contre CORP durci
Avec signature requise + anonyme désactivé, le bind anonyme et le relais NTLM→LDAP échouent.
