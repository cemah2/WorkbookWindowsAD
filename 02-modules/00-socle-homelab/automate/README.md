# Automate — Socle homelab (intro IaC)

Objectif de la Phase 0 : **prouver** que Proxmox est pilotable par code. L'IaC complète du
lab CORP arrive en Phase 3 ; ici on pose les fondations.

## Deux niveaux d'automatisation dans ce projet
1. **Ludus** — pour les *ranges* (GOAD, labs complets) : config YAML, `ludus range deploy`.
2. **Terraform** — pour provisionner des VM Proxmox à la carte (base de l'IaC de CORP).

## Exemple Terraform minimal
Voir `main.tf.example`. Il utilise le provider **bpg/proxmox**, se connecte via un **token API**
Proxmox (jamais de mot de passe en clair ; variables dans un `*.tfvars` **non commité** — voir
`.gitignore`), et crée une petite VM de test.

```bash
cp main.tf.example main.tf
# renseigne tes variables dans terraform.tfvars (NON commité)
terraform init
terraform plan
terraform apply      # crée la VM de test
terraform destroy    # la supprime
```

> Ne commite jamais `terraform.tfvars`, l'état `*.tfstate`, ni un token. Le `.gitignore` du
> dépôt bloque déjà `*.tfvars`.
