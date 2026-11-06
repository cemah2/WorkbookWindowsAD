# Attack — Abus de GPO

> ⚠️ Lab isolé uniquement (voir LEGAL.md). L'exploitation outillée (SharpGPOAbuse) se fait en
> Phase 5 ; ici on comprend le vecteur et on lit SYSVOL.

## Contexte / pré-requis
- Un principal disposant de droits d'**édition** sur une GPO liée (mauvaise délégation), ou
  simplement un compte authentifié pour lire SYSVOL.

## Techniques
- **MITRE ATT&CK** : T1484.001 (Group Policy Modification), T1552.006 (GPP Passwords), T1222 (ACL).
- **Outils** : PowerView (`Get-DomainGPO`, `Get-NetGPOGroup`), SharpGPOAbuse (P5), `Get-GPPPassword`.

## Déroulé
1. **Cartographier les droits d'édition de GPO** (qui peut écrire sur quelle GPO liée où) :
   ```powershell
   Get-GPO -All | ForEach-Object { Get-GPPermission -Name $_.DisplayName -All } |
     Where-Object { $_.Permission -match 'Edit|GpoEditDeleteModifySecurity' }
   ```
2. **Lire SYSVOL** (fuite d'infos, recherche de cpassword hérité) :
   ```bash
   # depuis un compte authentifié
   grep -r "cpassword" /mnt/sysvol 2>/dev/null   # si montage ; sinon via SMB
   ```
3. (P5) Une GPO éditable → ajout d'une tâche planifiée/immediate task => exécution sur les cibles.

## Ancrage réel
L'abus de GPO est un moyen d'escalade/propagation très prisé : un droit d'édition mal placé sur
une GPO liée à une OU de serveurs = compromission de ces serveurs. Les mots de passe GPP
(cpassword) ont causé de nombreuses compromissions historiques.

## Résultat attendu
Identifier les GPO éditables par des non-Tier 0 et tout secret dans SYSVOL — corrigé par `defend.md`.
