# Defend — Protéger LSASS & DPAPI

## Durcissement
1. **Credential Guard** (VBS) : isole les secrets LSASS → dump inutile.
2. **RunAsPPL** : LSASS en process protégé.
3. **WDigest off** : pas de mot de passe en clair en mémoire.
4. **Protéger la domain backup key DPAPI** : DC = Tier 0 (modules 22/26) ; limiter les droits de
   réplication (anti vol de la backup key).
5. **EDR** + Sysmon 10 pour détecter les accès LSASS.
6. **Limiter l'admin local** (le dump exige souvent l'admin) → LAPS/tiering.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Accès LSASS | Sysmon | 10 (TargetImage lsass.exe, GrantedAccess suspect) |
| Lecture master keys DPAPI | Sysmon/EDR | 11/accès fichiers Protect\<SID> |
| Vol domain backup key | Security (DC) | 4662 / accès LSA policy |

### Règle Sigma — accès aux master keys DPAPI
```yaml
title: Accès aux master keys DPAPI (possible vol de secrets)
logsource:
  product: windows
  service: sysmon
detection:
  selection:
    EventID: 11
    TargetFilename|contains: '\Microsoft\Protect\'
  condition: selection
level: medium
tags:
  - attack.credential_access
  - attack.t1555
```

## Preuve de détection (purple team)
Rejoue un accès LSASS et une extraction DPAPI (lab) ; vérifie Sysmon 10/11 + les règles (module 74).
Teste l'effet de RunAsPPL/Credential Guard (dump qui échoue).

## Rejouer contre CORP durci
Credential Guard + RunAsPPL + WDigest off + domain backup key protégée : LSASS ne livre rien
d'exploitable et DPAPI de masse est hors de portée.
