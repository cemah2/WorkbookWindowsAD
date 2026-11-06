# Attack — Le PDC Emulator comme levier

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Les FSMO ne sont pas une "attaque" en soi ; on montre
> pourquoi le PDC Emulator est une cible de choix et le lien avec d'autres techniques.

## Pourquoi le PDC Emulator
- **MITRE ATT&CK** : contexte T1207 (DCShadow), T1098, T1484.
- Source de **temps** (manipuler le temps peut perturber Kerberos/détection).
- Traitement **prioritaire des mots de passe** et **verrouillages**.
- Cible par défaut des outils **GPO** (un attaquant qui édite une GPO vise souvent le PDC).

## Déroulé (principe)
1. Après compromission d'un DC, repérer le détenteur PDC (`netdom query fsmo`).
2. Abus possibles liés : édition de GPO (module 20), DCShadow (module 26), persistance.
3. Une **saisie** malveillante de rôle n'a de sens qu'avec des droits déjà très élevés (Tier 0) —
   l'intérêt est surtout la **compréhension défensive**.

## Ancrage réel
La compromission d'un DC (a fortiori le PDC) est l'objectif final de la plupart des intrusions AD ;
les FSMO font partie de la cartographie que fait un attaquant une fois DA.

## Résultat attendu
Comprendre l'importance opérationnelle des FSMO pour mieux les surveiller (`defend.md`).
