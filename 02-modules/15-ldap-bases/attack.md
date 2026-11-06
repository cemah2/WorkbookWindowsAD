# Attack — Reconnaissance LDAP

> ⚠️ Lab isolé uniquement (voir LEGAL.md). LDAP est le canal de recon n°1.

## Techniques
- **MITRE ATT&CK** : T1087.002, T1069.002, T1018, T1482.
- **Outils** : `ldapsearch`, PowerView, **SharpHound/BloodHound**, `windapsearch`.

## Déroulé
1. Énumération large (authentifié) : users, groupes, ordinateurs, trusts.
2. Ciblage d'attributs à risque :
   ```bash
   ldapsearch -x -H ldap://10.10.0.10 -D 'jon.snow@corp.meridian.com' -w '***' \
     -b 'DC=corp,DC=meridian,DC=com' '(servicePrincipalName=*)' sAMAccountName servicePrincipalName
   ```
3. Collecte BloodHound (SharpHound) qui met l'annuaire en **graphe** d'attaque.

## Ancrage réel
SharpHound/BloodHound (collecte LDAP massive) est devenu l'outil standard des opérateurs réels
pour trouver le chemin vers Domain Admins. La recon LDAP précède presque toute escalade AD.

## Résultat attendu
Une cartographie des cibles (SPN, délégations, chemins vers Tier 0) — réduite par `defend.md`.
