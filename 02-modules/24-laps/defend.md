# Defend — Opérer LAPS en sécurité

## Durcissement
1. **Windows LAPS** partout (migrer depuis Legacy LAPS).
2. **Chiffrement** du mot de passe pour un groupe précis (pas de lecture en clair par un lecteur d'annuaire).
3. **ACL de lecture minimale** (par tier : les admins T2 lisent les postes, T1 les serveurs…).
4. **Rotation après lecture** + âge court.
5. Le compte admin local intégré ne doit pas être réutilisé entre machines.

## Détection
| Événement | Source | ID |
|---|---|---|
| Lecture de l'attribut mot de passe LAPS | Security (audit accès objet/attribut) | 4662 |
| Modification des attributs LAPS | Security | 5136 |
| Rotation/expiration | LAPS operational | — |

### Règle Sigma — lecture de l'attribut mot de passe LAPS
```yaml
title: Lecture de l'attribut mot de passe LAPS
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4662
    Properties|contains:
      - 'ms-Mcs-AdmPwd'
      - 'msLAPS-Password'
      - 'msLAPS-EncryptedPassword'
  condition: selection
level: medium
tags:
  - attack.credential_access
  - attack.t1555
```

## Preuve de détection (purple team)
Active l'audit d'accès à l'attribut, lis un mot de passe LAPS et vérifie le 4662 + la règle (P7).

## Rejouer contre CORP durci
Avec Windows LAPS chiffré + ACL par tier, un compromis de poste ne donne plus les mots de passe
des autres machines, et la lecture d'annuaire ne révèle rien en clair.
