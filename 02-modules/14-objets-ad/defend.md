# Defend — Protéger et surveiller les objets AD

## Durcissement
1. **Comptes sensibles dans `Protected Users`** + authentication policies/silos pour le Tier 0.
2. **Réduire les appartenances** aux groupes à privilèges (principe du moindre privilège) ;
   auditer régulièrement `Domain Admins`, `Account Operators`, `DnsAdmins`…
3. **Comptes de service** : préférer **gMSA/dMSA** (mots de passe gérés) aux comptes à SPN avec
   mot de passe statique (réduit le Kerberoasting).
4. **Supprimer DONT_REQ_PREAUTH** là où il n'est pas justifié (anti AS-REP roasting).
5. **AdminSDHolder/SDProp** : comprendre que les groupes protégés réappliquent leurs ACL.

## Détection
| Événement | Log | ID |
|---|---|---|
| Création de compte | Security | 4720 |
| Ajout à un groupe global/DL/universel sensible | Security | 4728 / 4732 / 4756 |
| Modification d'un compte | Security | 4738 |
| Modification d'attribut (si audit objet activé) | Security | 5136 |

### Règle Sigma — ajout à un groupe sensible
```yaml
title: Ajout d'un membre à un groupe à privilèges
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID:
      - 4728
      - 4732
      - 4756
    TargetUserName:
      - 'Domain Admins'
      - 'Enterprise Admins'
      - 'Administrators'
      - 'Account Operators'
  condition: selection
level: high
tags:
  - attack.persistence
  - attack.privilege_escalation
  - attack.t1098
```

## Preuve de détection (purple team)
Ajoute un compte de test à `Domain Admins` (puis retire-le) et vérifie le 4728/4732 et la règle.
Atomic Red Team propose des tests T1098 pour rejouer proprement.

## Rejouer contre CORP durci
Mets les comptes admin dans `Protected Users`, convertis un compte de service en gMSA, puis
relance l'énumération SPN/AS-REP de `attack.md` : la surface Kerberoasting/AS-REP doit diminuer.
