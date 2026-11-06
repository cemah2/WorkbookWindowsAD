# Defend — Protéger le pont hybride

## Durcissement
1. **Entra Connect = Tier 0** : serveur dédié, isolé, PAW, pas d'autres rôles, mises à jour.
2. **Ne pas synchroniser le Tier 0 on-prem** (filtrage d'OU).
3. **Protéger les comptes de synchro** : restreindre `MSOL_*`, surveiller leur usage ; **roter
   AZUREADSSOACC$** régulièrement.
4. Préférer **PHS** (moins de surface que PTA/ADFS) ; si ADFS, protéger la **clé de signature** (HSM).
5. **MFA** sur les comptes à privilèges cloud ; Conditional Access (module 64).

## Détection
| Source | Signal |
|---|---|
| Security (on-prem) | DCSync depuis le serveur Connect (4662), usage anormal de `MSOL_*` |
| Entra Audit/Sign-in | activité du compte de synchro, modifications de config |
| ADFS logs | émission de tokens anormale (Golden SAML) |

### Règle Sigma — DCSync depuis le serveur Entra Connect (anormal si inattendu)
```yaml
title: Réplication (DCSync) impliquant un compte de synchro hors contexte
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4662
    Properties|contains: '1131f6aa-9c07-11d1-f79f-00c04fc2dcd2'
  condition: selection
level: medium
tags:
  - attack.credential_access
  - attack.t1003.006
```

## Preuve de détection (purple team)
Simule l'extraction des creds de synchro (lab) et une synchro, vérifie l'activité `MSOL_*` et les logs
Entra. Teste la rotation d'AZUREADSSOACC$.

## Rejouer contre CORP durci
Serveur Connect en Tier 0 + PHS + comptes de synchro protégés + AZUREADSSOACC$ roté : les pivots
hybrides deviennent beaucoup plus difficiles et détectés.
