# Defend — Couper la coercition et le relais

## Durcissement (les contre-mesures qui marchent)
1. **Imposer la signature** : **SMB signing** requis, **LDAP signing + channel binding** requis
   (modules 10/15/17) → casse la majorité des relais.
2. **EPA** (Extended Protection for Authentication) sur les services HTTP (AD CS, OWA).
3. **Réduire/désactiver NTLM** (déprécié 2025) ; **Protected Users** pour les comptes sensibles.
4. **Désactiver les déclencheurs** de coercition quand possible (correctifs, filtrage RPC, désactiver
   le Spooler sur les DC pour PrinterBug).
5. **Segmenter** : limiter qui peut joindre les services relayables.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Coercition (MS-EFSRPC/MS-RPRN) | réseau / Defender for Identity | appels EfsRpc*/RpcRemoteFindFirstPrinterChangeNotification |
| Auth NTLM d'un compte machine vers hôte inattendu | Security | 4624/4625 NTLM, compte `$` |
| Émission cert pour compte machine (ESC8) | AD CS | 4886 requester `$` |

### Règle Sigma — authentification NTLM entrante d'un compte machine (relais possible)
```yaml
title: Authentification NTLM d'un compte machine vers un hôte inattendu
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4624
    AuthenticationPackageName: 'NTLM'
    TargetUserName|endswith: '$'
  condition: selection
level: medium
tags:
  - attack.credential_access
  - attack.t1557.001
```

## Preuve de détection (purple team)
Rejoue PetitPotam + relais en lab, vérifie la coercition (réseau) + 4624 NTLM compte machine + 4886
(si ADCS) + les règles (P7). Puis active la signature et constate l'échec du relais.

## Rejouer contre CORP durci
Signature SMB/LDAP + EPA + NTLM réduit + Spooler off sur DC : coercition toujours possible mais le
**relais échoue** → chaîne cassée.
