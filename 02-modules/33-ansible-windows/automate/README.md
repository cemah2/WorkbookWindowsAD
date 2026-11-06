# Automate — Ansible Windows
Exemples : `inventory.yml`, `site.yml` (rôles/services + AD via microsoft.ad). Base du module 35
(reconstruire CORP). Les secrets vont dans Ansible Vault, jamais dans le dépôt (.gitignore).
## Usage
```bash
ansible-playbook -i inventory.yml site.yml --ask-vault-pass
```
