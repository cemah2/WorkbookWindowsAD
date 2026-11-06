# Drills — Ansible Windows

## Drill 1 — Ping Windows (10 min)
- **Étapes** : `ansible -i inventory.yml fileservers -m ansible.windows.win_ping`.
- **Observer** : connexion WinRM OK (pong).
- **Pourquoi** : valider la plomberie avant tout.

## Drill 2 — Tâche idempotente (10 min)
- **Étapes** : joue un `win_feature` 2x.
- **Observer** : `changed` puis `ok` (changed=0).
- **Pourquoi** : l'idempotence en pratique.

## Drill 3 — microsoft.ad (15 min)
- **Étapes** : crée une OU + un user via `microsoft.ad`, vérifie dans ADUC.
- **Pourquoi** : gérer AD en YAML.

## Drill 4 — Vault (10 min)
- **Étapes** : stocke un mot de passe en Vault, utilise-le dans un playbook.
- **Pourquoi** : ne jamais exposer de secret.

## Drill break-fix — Auth WinRM échoue (10 min)
- **Casse** : mauvais transport (ntlm sans fallback) ou ticket Kerberos absent.
- **Diagnostique** : erreur d'auth ; `klist` (Linux), `-vvvv` sur ansible.
- **Répare** : `kinit user@CORP.MERIDIAN.COM`, corrige `ansible_winrm_transport`, re-teste.
