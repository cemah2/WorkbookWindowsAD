# Attack — Compromission du pipeline IaC

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1552 (Unsecured Credentials), T1078, T1584/T1525 (infrastructure/images).
- **Principe** : le **state** et le **token API** Proxmox donnent les clés de toute l'infra.

## Déroulé (principe)
1. Récupération d'un `terraform.tfstate` ou d'un `terraform.tfvars` mal protégé (souvent committé
   par erreur !) → token API Proxmox + topologie.
2. Avec le token : création/suppression de VM, accès à l'hyperviseur.
3. Injection d'une VM/backdoor dans le pipeline (template empoisonné).

## Ancrage réel
Les secrets d'IaC committés par erreur (tokens, clés) sont une source massive de compromission
cloud/infra (scans GitHub automatisés). Le state Terraform contient souvent des secrets en clair.

## Résultat attendu
Comprendre pourquoi state/secrets doivent être protégés — traité dans `defend.md`.
