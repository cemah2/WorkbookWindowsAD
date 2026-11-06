# Attack — Détourner l'automatisation de configuration

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1072 (Software Deployment Tools), T1484, T1525.
- **Principe** : qui contrôle l'outil de configuration (DSC Pull server, MOF) contrôle le parc.

## Déroulé (principe)
1. Compromission du **Pull server** ou des **MOF** distribués.
2. Injection d'une configuration malveillante (service, tâche, compte) appliquée à grande échelle,
   et **ré-appliquée** par le LCM (persistance : si on nettoie, DSC "corrige" vers l'état malveillant).
3. Secrets en clair dans un MOF non chiffré → vol de credentials.

## Ancrage réel
Les outils de déploiement/configuration (SCCM, DSC, GPO) sont des cibles de choix pour la
distribution massive de malware/persistance — catégorie ATT&CK dédiée (T1072).

## Résultat attendu
Comprendre que l'infrastructure d'automatisation est **Tier 0-sensible** — durcie dans `defend.md`.
