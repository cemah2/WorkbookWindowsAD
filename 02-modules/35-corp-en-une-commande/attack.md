# Attack — Le pipeline IaC complet comme cible ultime

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Synthèse des modules 32-34.

## Techniques
- **MITRE ATT&CK** : T1072 (Software Deployment Tools), T1552 (Unsecured Credentials),
  T1078, T1584/T1525.
- **Principe** : le pipeline qui construit CORP **est** le chemin le plus court vers CORP entier.

## Déroulé (principe)
1. Compromission d'un maillon : contrôleur Ansible, state/token Terraform, Vault, ou template Packer.
2. → capacité à provisionner/configurer **tout** le parc (backdoor, compte, persistance) de façon
   « légitime » et **ré-appliquée** à chaque run.
3. Un template empoisonné propage la compromission à chaque nouvelle VM.

## Ancrage réel
Les compromissions de chaîne d'approvisionnement/outils de déploiement sont parmi les plus
impactantes (un point → tout). D'où le traitement du pipeline comme un actif Tier 0.

## Résultat attendu
Comprendre que sécuriser le pipeline = sécuriser CORP. Synthèse défensive dans `defend.md`.
