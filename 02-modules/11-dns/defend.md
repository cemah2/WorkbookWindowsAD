# Defend — Durcir et surveiller le DNS

## Durcissement
1. **Bloquer les transferts de zone** (ou les restreindre aux seuls DC) :
   ```powershell
   Set-DnsServerPrimaryZone -Name "corp.meridian.com" -SecureSecondaries "NoTransfer"
   ```
2. **Mises à jour dynamiques : Secure only** (jamais "Nonsecure and secure").
3. **Surveiller le groupe `DnsAdmins`** (potentiel d'exécution de code sur le DC) : appartenance
   minimale, traitée comme Tier 0.
4. **Scavenging** activé pour éviter les enregistrements fantômes.
5. **Protéger les noms sensibles** (ex. créer explicitement `wpad`/`isatap` ou les bloquer via
   la *Global Query Block List*).

## Détection
| Événement | Source | ID |
|---|---|---|
| Transfert de zone demandé | DNS Server (audit/analytique) | 6001 (selon config) |
| Création/suppression d'enregistrement | DNS Server audit | 516/517/518… |
| Modification d'appartenance DnsAdmins | Security | 4728/4732 |

### Règle Sigma — tentative de transfert de zone (AXFR)
```yaml
title: Tentative de transfert de zone DNS (AXFR)
logsource:
  product: windows
  service: dns-server
detection:
  selection:
    EventID: 6001      # ajuster selon la source d'audit DNS activée
  condition: selection
level: medium
tags:
  - attack.discovery
  - attack.t1590
```

## Preuve de détection (purple team)
Lance `dig AXFR` depuis l'attaquant, vérifie le refus et l'entrée d'audit, puis (P7) le
déclenchement de la règle dans le SIEM.

## Rejouer contre le DNS durci
Après `SecureSecondaries NoTransfer` et "Secure only", relance `dig AXFR` et une mise à jour
non authentifiée : les deux doivent échouer.
