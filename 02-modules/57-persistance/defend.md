# Defend — Détecter la persistance et éradiquer

## Durcissement / éradication
1. **Rotation krbtgt x2** (avec délai de réplication) → invalide les Golden Tickets.
2. **Révoquer** les certificats suspects ; auditer **NTAuthCertificates** et **msDS-KeyCredentialLink**.
3. Auditer **AdminSDHolder**, **sIDHistory**, comptes/GPO ajoutés.
4. **Protected Users** + tiering + Credential Guard (réduire la surface initiale).
5. Compromission profonde → **Forest Recovery** (module 29).

## Détection
| Événement | Source | Signal |
|---|---|---|
| TGT forgé (Golden) | Security | 4768 absent mais 4769 présents ; durée/anomalies PAC |
| Silver Ticket | Security | 4624/4634 sans 4768/4769 correspondants sur le DC |
| Modif AdminSDHolder | Security | 5136 (conteneur AdminSDHolder) |
| sIDHistory ajouté | Security | 4765/4766 |
| DCShadow | Security | 4928/4929, nTDSDSA |

### Règle Sigma — modification d'AdminSDHolder (persistance par ACL)
```yaml
title: Modification de l'ACL d'AdminSDHolder
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    ObjectDN|contains: 'CN=AdminSDHolder,CN=System'
  condition: selection
level: high
tags:
  - attack.persistence
  - attack.t1098
```

## Preuve de détection (purple team)
Pose un Golden Ticket et une ACE AdminSDHolder (lab), vérifie les anomalies + 5136, puis exécute
l'éradication (krbtgt x2) et confirme que le Golden ne marche plus.

## Rejouer contre CORP durci
Avec surveillance + éradication complète (krbtgt x2, certs révoqués, ACL nettoyées), la persistance
est détectée et éliminée.
