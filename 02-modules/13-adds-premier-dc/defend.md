# Defend — Durcir et surveiller un nouveau DC

> Fermer ce que `attack.md` a révélé, et détecter la reconnaissance. Durcissement de base ;
> le tiering, les GPO de sécurité et LAPS viennent en Phase 2.

## Durcissement

1. **Couper les binds LDAP anonymes** (par défaut déjà restreint en versions récentes, à vérifier) :
   l'attribut `dsHeuristics` ne doit **pas** autoriser l'anonyme ; contrôler l'ACL de la racine.
2. **Imposer la signature LDAP + channel binding** (prépare la défense anti-relais, module 54) :
   via GPO *Domain Controllers* →
   `Domain controller: LDAP server signing requirements = Require signing`.
3. **Signature SMB** requise sur le DC (`Set-SmbServerConfiguration -RequireSecuritySignature $true`).
4. **Protéger SYSVOL** : vérifier qu'aucun mot de passe GPP n'y traîne (héritage) ; permissions saines.
5. **Sauvegarde** : activer la *Windows Server Backup* / PBS du system state dès maintenant (module 29).
6. **Heure** : le DC PDC-emulator est la source de temps — le configurer sur une source fiable.

## Détection

| Événement | Log | Event ID |
|---|---|---|
| Énumération / échecs d'auth | Security | 4625, 4768/4771 (Kerberos pré-auth échouée) |
| Requêtes LDAP coûteuses / anormales | Directory Service | 1644 (si audit activé) |
| Accès à SYSVOL/NETLOGON | Security (audit d'objet) | 4663 |
| Changement d'appartenance à un groupe sensible | Security | 4728/4732/4756 |

### Règle Sigma — énumération d'utilisateurs via Kerberos (pré-auth échouée en rafale)
```yaml
title: Énumération Kerberos possible (4768 refusés en rafale)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4768
    ResultCode: '0x6'   # client principal inconnu
  timeframe: 2m
  condition: selection | count() by IpAddress > 10
level: medium
tags:
  - attack.discovery
  - attack.t1087
```

## Preuve de détection (purple team)
Relance l'énumération de `attack.md` (ou Atomic Red Team T1087) et vérifie l'apparition des
4768/4625 et le déclenchement de la règle une fois le SIEM en place (P7).

## Rejouer contre le DC durci
Après avoir imposé signature LDAP/SMB et vérifié l'anonyme : relance `ldapsearch` anonyme et
`netexec smb -u '' -p '' --shares`. L'information divulguée doit chuter nettement — on verra
l'effet concret quand on tentera un relais NTLM (module 54), désormais bloqué par la signature.
