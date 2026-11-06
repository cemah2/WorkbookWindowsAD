# Build — Configurer Windows avec Ansible (dans CORP)

## Pré-requis
- Contrôleur Linux (ton poste). Cibles Windows avec WinRM activé (module 31).

## Étape 1 — Installer Ansible + dépendances (contrôleur Linux)
```bash
python3 -m pip install --user ansible pywinrm requests-kerberos
ansible-galaxy collection install microsoft.ad ansible.windows community.windows
```

## Étape 2 — Inventaire
`inventory.yml` :
```yaml
all:
  children:
    domaincontrollers:
      hosts:
        par-dc-01.corp.meridian.com:
    fileservers:
      hosts:
        par-fs-01.corp.meridian.com:
  vars:
    ansible_connection: winrm
    ansible_winrm_transport: kerberos   # ou ntlm ; credssp à éviter
    ansible_port: 5985
```

## Étape 3 — Playbook : garantir rôle + service (idempotent)
`site.yml` :
```yaml
- hosts: fileservers
  tasks:
    - name: Rôle DFS présent
      ansible.windows.win_feature:
        name: FS-DFS-Namespace
        state: present
    - name: Service Spooler désactivé (durcissement exemple)
      ansible.windows.win_service:
        name: Spooler
        start_mode: disabled
        state: stopped
```

## Étape 4 — Gérer AD avec microsoft.ad
```yaml
- hosts: domaincontrollers
  tasks:
    - name: OU EMEA présente
      microsoft.ad.ou:
        name: EMEA
        path: "OU=Employees,DC=corp,DC=meridian,DC=com"
        state: present
    - name: Utilisateur de test
      microsoft.ad.user:
        identity: test.ansible
        firstname: Test
        surname: Ansible
        password: "{{ vault_user_pw }}"     # depuis Ansible Vault
        path: "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com"
        state: present
```

## Étape 5 — Secrets avec Ansible Vault
```bash
ansible-vault create group_vars/all/vault.yml   # y mettre vault_user_pw, etc.
ansible-playbook -i inventory.yml site.yml --ask-vault-pass
```

## Étape 6 — Lancer et vérifier l'idempotence
```bash
ansible-playbook -i inventory.yml site.yml --ask-vault-pass   # 1re exécution: changed
ansible-playbook -i inventory.yml site.yml --ask-vault-pass   # 2e: ok=... changed=0
```

## Vérification
- `changed=0` à la 2e exécution (idempotence). Les objets/ rôles sont présents sur les cibles.

## Pièges courants
- WinRM/Kerberos mal configuré (kinit, SPN, DNS) → connexion qui échoue.
- Secrets en clair (toujours Vault).
- Mélanger versions de collections incompatibles.
