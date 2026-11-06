# Defend — Opérer et surveiller le tiering

## Durcissement (rappel)
1. Comptes d'admin **séparés par tier**, jamais réutilisés.
2. **Deny logon croisés** (GPO) + **PAW** pour le Tier 0.
3. **Protected Users** + **silos d'authentification** pour les comptes Tier 0.
4. **LAPS** (module 24) pour casser le rebond latéral entre postes.
5. Accès **break-glass** documenté et surveillé.

## Détection
| Événement | Signal | ID |
|---|---|---|
| Session d'un compte T0 hors Tier 0 | Violation de tiering (anomalie forte) | 4624 (corrélé au tier de l'hôte) |
| Échec deny logon | Tentative de session interdite | 4625 |
| Usage d'un compte admin sur hôte inattendu | Mouvement latéral | 4624/4648 |
| Membre ajouté à un groupe Tier 0 | Escalade | 4728/4732 |

### Règle Sigma — ouverture de session d'un compte Tier 0 hors périmètre
```yaml
title: Compte Tier 0 utilisé hors d'un hôte Tier 0
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4624
    TargetUserName|startswith: 'adm-t0-'
  filter_t0hosts:
    Computer|startswith:
      - 'PAR-DC-'
      - 'PAW-'
  condition: selection and not filter_t0hosts
level: critical
tags:
  - attack.lateral_movement
  - attack.t1078
```

## Preuve de détection (purple team)
Connecte volontairement un compte `adm-t0-*` à un serveur T1 (hors deny logon de test) et vérifie
que la règle se déclenche. Confirme aussi le 4625 quand le deny logon bloque.

## Rejouer contre CORP durci
Après tiering complet, le scénario de `attack.md` échoue : le credential T0 n'apparaît jamais sur
un hôte compromis, et BloodHound ne montre plus de chemin T2→T0.
