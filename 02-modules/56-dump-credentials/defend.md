# Defend — Protéger les credentials

## Durcissement
1. **Credential Guard** (isole les secrets LSASS via virtualisation) + **LSA Protection (RunAsPPL)**.
2. **WDigest désactivé** (pas de mot de passe en clair en mémoire).
3. **Protected Users** + tiering (modules 22) → moins de credentials exposés.
4. **Restreindre les droits de réplication** (anti-DCSync, module 26) ; DC en Tier 0.
5. **Rotation krbtgt** (2x) si suspicion ; sauvegardes protégées.
6. **EDR** surveillant l'accès à LSASS.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Accès à LSASS | Sysmon | 10 (TargetImage lsass.exe, GrantedAccess suspect) |
| DCSync par non-DC | Security | 4662 (GUID DS-Replication) |
| vssadmin/ntdsutil | Security/Sysmon | 4688 / Sysmon 1 |
| reg save de ruches | Sysmon | 1 (reg.exe save HKLM\SAM) |

### Règle Sigma — accès suspect à LSASS
```yaml
title: Accès mémoire suspect à LSASS (dump de credentials)
logsource:
  product: windows
  category: process_access
detection:
  selection:
    TargetImage|endswith: '\lsass.exe'
    GrantedAccess:
      - '0x1010'
      - '0x1410'
      - '0x1438'
      - '0x143a'
  condition: selection
level: high
tags:
  - attack.credential_access
  - attack.t1003.001
```

## Preuve de détection (purple team)
Rejoue un dump LSASS et un DCSync (lab) et vérifie Sysmon 10 / 4662 + les règles (P7). Atomic Red Team
T1003 propose des tests.

## Rejouer contre CORP durci
Credential Guard + WDigest off + droits de réplication restreints : LSASS ne livre rien d'exploitable
et le DCSync non autorisé échoue.
