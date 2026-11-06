# Defend — Contrer les Shadow Credentials

## Durcissement
1. **ACL strictes** : personne (hors Tier 0 légitime) ne doit pouvoir écrire `msDS-KeyCredentialLink`
   sur des comptes sensibles (DC, admins) — audit BloodHound/`Get-AclReport.ps1` (module 21).
2. **Mapping fort** des certificats (KB5014754) + contrôle de **NTAuthCertificates** (module 40).
3. **Protected Users** pour les comptes sensibles.
4. Surveiller/alerter sur toute écriture de `msDS-KeyCredentialLink`.

## Détection
| Événement | Source | ID |
|---|---|---|
| Écriture de msDS-KeyCredentialLink | Security | 5136 (attribut) |
| Authentification PKINIT | Security | 4768 (PreAuthType 16) |

### Règle Sigma — écriture de msDS-KeyCredentialLink
```yaml
title: Écriture de msDS-KeyCredentialLink (Shadow Credentials)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    AttributeLDAPDisplayName: 'msDS-KeyCredentialLink'
  condition: selection
level: high
tags:
  - attack.persistence
  - attack.t1098
```

## Preuve de détection (purple team)
Rejoue `certipy shadow auto` et vérifie 5136 (msDS-KeyCredentialLink) + 4768 PKINIT + la règle (P7).

## Rejouer contre CORP durci
Avec ACL propres (pas d'AddKeyCredentialLink non justifié) + mapping fort : l'attaque échoue et toute
écriture légitime reste visible/alertée.
