# Automate — CORP en une commande
Squelettes d'orchestration : `deploy-corp.sh`, `destroy-corp.sh`, `gen_inventory.py`. Ils assemblent
Terraform (module 34), Ansible (module 33) et DSC (module 32). Secrets via Vault/tfvars hors dépôt.
## Usage
```bash
./deploy-corp.sh     # crée + configure CORP
./destroy-corp.sh    # détruit
```
