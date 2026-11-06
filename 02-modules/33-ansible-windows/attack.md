# Attack — Le contrôleur d'orchestration comme cible

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1072 (Software Deployment Tools), T1552 (Unsecured Credentials), T1021.006.
- **Principe** : compromettre le contrôleur Ansible = exécuter sur TOUT le parc avec ses droits.

## Déroulé (principe)
1. Accès au **contrôleur Ansible** (clés SSH, inventaire, Vault).
2. Si le **Vault** est déchiffrable (mot de passe faible/stocké) ou les secrets en clair → vol des
   credentials d'admin du parc.
3. Injection d'une tâche malveillante dans un playbook → exécution de masse (WinRM).

## Ancrage réel
Les serveurs d'automatisation/déploiement sont des cibles stratégiques (un seul point → tout le
parc). Catégorie ATT&CK dédiée (T1072).

## Résultat attendu
Comprendre que le contrôleur et ses secrets sont **Tier 0-sensibles** — durci dans `defend.md`.
