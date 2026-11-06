# Automate — Terraform (Proxmox)
Exemples : `providers.tf`, `variables.tf`, `dc.tf`. Base du module 35 (CORP en une commande).
NE JAMAIS committer `terraform.tfvars` ni `terraform.tfstate` (secrets) — bloqués par .gitignore.
## Usage
```bash
cp terraform.tfvars.example terraform.tfvars   # renseigner endpoint + token
terraform init && terraform plan && terraform apply
```
