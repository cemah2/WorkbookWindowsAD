# Defend — Maîtriser les délégations et ACL

## Durcissement
1. **Moindre privilège** : déléguer des tâches précises à des groupes, sur l'OU minimale.
2. **Audit régulier des ACL** (BloodHound défensif, PingCastle, `Get-AclReport.ps1`) : traquer
   GenericAll/WriteDACL/WriteOwner/ForceChangePassword non justifiés.
3. **Protéger le Tier 0** : aucun non-Tier 0 ne doit avoir d'ACL sur DC/Admins/GPO liées au domaine.
4. **Surveiller `msDS-KeyCredentialLink`** (Shadow Credentials).
5. S'appuyer sur **AdminSDHolder/SDProp** pour les comptes protégés (ne pas le contourner).

## Détection
| Événement | Source | ID |
|---|---|---|
| Modification de descripteur de sécurité | Security | 5136 (nTSecurityDescriptor) |
| Réinitialisation de mot de passe | Security | 4724 |
| Ajout à un groupe | Security | 4728/4732/4756 |
| Écriture de msDS-KeyCredentialLink | Security | 5136 (attribut) |

### Règle Sigma — modification d'ACL sur objet AD
```yaml
title: Modification du descripteur de sécurité d'un objet AD
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 5136
    AttributeLDAPDisplayName: 'nTSecurityDescriptor'
  condition: selection
level: high
tags:
  - attack.privilege_escalation
  - attack.t1222
```

## Preuve de détection (purple team)
Pose/retire une ACE de test et vérifie le 5136 (audit "Directory Service Changes"), puis la règle
dans le SIEM (P7). Lance BloodHound défensif pour confirmer la disparition du chemin.

## Rejouer contre CORP durci
Après nettoyage des ACL excessives, BloodHound ne doit plus montrer de chemin d'escalade vers le
Tier 0 depuis un compte standard.
