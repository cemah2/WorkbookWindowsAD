# Defend — Durcir AD CS contre les ESC

## Durcissement (par famille)
- **Templates (ESC1/2/3/9/13/15)** : Subject *Build from AD*, pas d'EKU d'auth inutile, Enroll ciblé,
  manager approval, retirer SubCA/Any Purpose, patcher (ESC15/EKUwu).
- **Permissions (ESC4/5/7)** : ACL strictes sur templates, objets Public Key Services, et sur la CA
  (ManageCA/ManageCertificates réservés au Tier 0).
- **Réseau/relais (ESC8/11)** : pas de Web Enrollment HTTP (sinon HTTPS+EPA), signature RPC
  (`IF_ENFORCEENCRYPTICERTREQUEST`), réduire NTLM, signature SMB/LDAP, Protected Users.
- **Mapping/clés (ESC6/10/12/14/16)** : retirer `EDITF_ATTRIBUTESUBJECTALTNAME2`, **mapping fort**
  (KB5014754 : `StrongCertificateBindingEnforcement=2`), protéger les clés de CA (HSM), mapping
  explicite fort (`altSecurityIdentities` avec identifiants forts).
- **Général** : CA = Tier 0, audit AD CS activé, revue régulière (Certipy/Locksmith/PingCastle).

## Détection
| Événement | Source | ID / Signal |
|---|---|---|
| Certificat émis | AD CS audit | 4886/4887 (corréler SAN vs requester) |
| Cert d'auth pour un compte machine (ESC8) | AD CS | 4886 requester se terminant par `$` |
| Changement de config CA | AD CS | 4890-4899 |
| Modif de template/objet PKI | Security | 5136 |
| Coercition (PetitPotam) + relais | réseau/NTLM | corrélation EfsRpc + 4886 |

### Règle Sigma — émission suspecte (SAN ne correspond pas / compte machine)
```yaml
title: Émission de certificat suspecte (possible ESC1/ESC8)
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4886
  machine_requester:
    Requester|endswith: '$'
  condition: selection and machine_requester
level: high
tags:
  - attack.credential_access
  - attack.t1649
```

## Preuve de détection (purple team)
Rejoue chaque ESC en lab isolé, vérifie 4886/5136 et le déclenchement des règles (P7), puis applique
le durcissement et confirme avec `certipy find -vulnerable` (liste vide) et un re-test de l'attaque
(échec). C'est le cœur de la boucle attaque→détection→remédiation→re-test.

## Rejouer contre CORP durci
Avec templates sûrs, ACL strictes, mapping fort, pas de relais possible, et CA en Tier 0 : les ESC
exploités précédemment échouent et sont détectés.
