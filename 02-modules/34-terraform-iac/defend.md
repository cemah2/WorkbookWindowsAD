# Defend — Sécuriser Terraform / le pipeline IaC

## Durcissement
1. **Ne jamais committer** `terraform.tfstate`, `*.tfvars`, tokens (bloqués par .gitignore ; scanner
   le dépôt avec gitleaks).
2. **Remote state** chiffré + verrouillage (backend) pour le travail en équipe.
3. **Token API Proxmox** à portée minimale (permissions limitées) ; rotation.
4. **Revue de code** des `.tf` ; versions de provider épinglées.
5. Templates/images **de confiance** (Packer versionné), intégrité vérifiée.

## Détection
| Événement | Source | Signal |
|---|---|---|
| Actions API Proxmox inhabituelles | Proxmox task log / syslog | création/suppression de VM hors fenêtre |
| Secret committé | Scan dépôt (gitleaks) | détection de token |
| Modif de state | Backend/versioning | diff inattendu |

### Règle (conceptuelle) — secret IaC détecté dans le dépôt
```yaml
# À exécuter en CI (gitleaks), pas un log Windows :
title: Secret IaC potentiel committé (token/tfvars/tfstate)
detection:
  patterns:
    - '!*\.tfstate'
    - '!*\.tfvars'
    - 'pve_api_token'
  condition: any pattern present in commit
level: high
tags:
  - attack.t1552
```

## Preuve de détection (purple team)
Tente de committer un faux token (dans une branche jetable) et vérifie que gitleaks/CI le bloque ;
vérifie que `.gitignore` empêche l'ajout de `*.tfstate`/`*.tfvars`.

## Rejouer contre CORP durci
Avec state chiffré distant + token minimal + scan de secrets, une fuite de fichier local ne donne
plus les clés de l'infra.
