# Drills — Tokens & privilèges

## Drill 1 — whoami /all décodé (10 min)
- **Étapes** : lis SID, groupes, privilèges, integrity level ; identifie les privilèges sensibles.
- **Pourquoi** : savoir évaluer ce qu'un compte peut faire.

## Drill 2 — Comparer deux tokens (10 min)
- **Étapes** : compare le token d'un user et d'un process SYSTEM (Process Explorer).
- **Observer** : différences d'integrity/privilèges.

## Drill 3 — Privilèges d'un compte de service (10 min)
- **Étapes** : vérifie SeImpersonate sur un compte de service (ex. IIS/SQL).
- **Pourquoi** : comprendre la surface « Potato ».

## Drill 4 — User Rights via GPO (10 min)
- **Étapes** : inspecte les User Rights Assignment appliqués (gpresult/secpol).
- **Pourquoi** : d'où viennent les privilèges (lien tiering).

## Drill break-fix — Privilège manquant (10 min)
- **Casse** : retire un privilège nécessaire à une tâche d'admin légitime (GPO).
- **Diagnostique** : l'action échoue (access denied) ; `whoami /priv`.
- **Répare** : rétablir le droit au bon groupe ; comprendre le moindre privilège.
