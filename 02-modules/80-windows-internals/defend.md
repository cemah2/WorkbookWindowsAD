# Defend — Observer et durcir au niveau système

## Durcissement (socle)
1. **Credential Guard / VBS / HVCI** : isole les secrets et protège le kernel.
2. **PPL (RunAsPPL)** pour LSASS (module 82).
3. **ASR rules** (Attack Surface Reduction) : bloquer des comportements (ex. création de process par Office).
4. **WDAC/AppLocker** : contrôle d'exécution (limite injection/sideloading/BYOVD).
5. **EDR** : télémétrie + réponse (module 84).

## Détection (via Sysmon/EDR)
| Mécanisme | Signal | Source |
|---|---|---|
| Lineage anormal | parent/enfant suspect | Sysmon 1 |
| Injection | CreateRemoteThread / mem | Sysmon 8 / EDR |
| DLL sideloading | DLL hors chemin attendu | Sysmon 7 |
| Accès LSASS | handle/ProcessAccess | Sysmon 10 |
| Driver suspect (BYOVD) | chargement de driver | Sysmon 6 / EDR |

### Règle Sigma — chargement d'un driver non signé/suspect (BYOVD indice)
```yaml
title: Chargement de driver potentiellement vulnérable (BYOVD)
logsource:
  product: windows
  service: sysmon
detection:
  selection:
    EventID: 6
  filter_signed:
    Signed: 'true'
  condition: selection and not filter_signed
level: medium
tags:
  - attack.privilege_escalation
  - attack.t1068
```

## Preuve de détection (purple team)
Observer, via Sysmon, le lineage/DLL/handle d'une action de lab (modules 81-84) et confirmer les events
correspondants (module 74).

## Rejouer contre CORP durci
Avec Credential Guard + WDAC + ASR + EDR, injection, dump LSASS et BYOVD deviennent difficiles et visibles.
