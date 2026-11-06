# Attack — Escalade par appartenance de groupe

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1098 (Account Manipulation), T1078 (Valid Accounts).
- **Outils** : BloodHound (MemberOf edges), PowerView.

## Déroulé
1. **Déplier les appartenances** vers les groupes sensibles :
   ```powershell
   Get-ADGroupMember "Domain Admins" -Recursive
   ```
2. Repérer un **groupe imbriqué** peu surveillé qui donne indirectement des droits élevés (ex. un
   groupe "support" ajouté par erreur dans un groupe privilégié).
3. Compromettre un membre de ce groupe faible = hériter des droits élevés (sans toucher
   directement "Domain Admins").

## Ancrage réel
Les chemins d'escalade par imbrication (souvent hérités d'années d'administration) sont un grand
classique révélé par BloodHound dans quasiment tous les audits AD.

## Résultat attendu
Lister les imbrications dangereuses de CORP — corrigées par `defend.md`.
