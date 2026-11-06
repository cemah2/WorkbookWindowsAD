# Defend — Sécuriser le pipeline de bout en bout

## Durcissement (synthèse)
1. **Pipeline = Tier 0** : contrôleur, state, Vault, templates → accès strict, durcis, surveillés.
2. **Secrets** : Vault/remote state chiffrés, tokens à portée minimale, rotation ; **rien** dans le
   dépôt (scan gitleaks + .gitignore).
3. **Intégrité** : templates/collections/providers **épinglés** et vérifiés ; revue de code des IaC.
4. **Moindre privilège** à chaque couche ; séparation des environnements.
5. **Traçabilité** : versionner tout, journaliser les runs (qui a déployé quoi, quand).

## Détection (synthèse)
| Événement | Source | Signal |
|---|---|---|
| Création/destruction massive de VM | Proxmox task log | hors fenêtre planifiée |
| Exécutions de masse (config) | Windows (wsmprovhost) | rafale 4624/4688 |
| Secret committé | CI (gitleaks) | token/clé détecté |
| Modif de template/état | Git/backend | diff inattendu |

### Règle (conceptuelle, CI) — bloquer un secret dans un commit IaC
```yaml
title: Secret potentiel dans un commit IaC
detection:
  patterns:
    - 'pve_api_token'
    - 'BEGIN (RSA|OPENSSH) PRIVATE KEY'
    - '*.tfstate'
  condition: any pattern present
level: high
tags:
  - attack.t1552
```

## Preuve de détection (purple team)
Exécute un `deploy`/`destroy` et observe les traces Proxmox + la rafale WinRM ; tente de committer
un secret et vérifie que la CI/gitleaks bloque.

## Rejouer contre CORP durci
Pipeline isolé, secrets chiffrés, versions épinglées, runs journalisés : un maillon partiellement
compromis ne donne plus le contrôle de tout CORP sans être détecté.
