# Attack — Lire l'annuaire comme un attaquant

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Avec un compte **peu privilégié**, un attaquant
> cartographie déjà tout l'annuaire. On observe ici la valeur des attributs — l'exploitation
> (Kerberoasting, AS-REP, Shadow Creds) est détaillée en Phase 5.

## Contexte / pré-requis
- Un compte utilisateur standard valide (ex. `jon.snow`) — par défaut, un user authentifié
  peut **lire** l'essentiel de l'annuaire.

## Techniques
- **MITRE ATT&CK** : T1087.002 (Domain Account Discovery), T1069.002 (Domain Groups),
  T1078 (Valid Accounts).
- **Outils** : module `ActiveDirectory`, PowerView, BloodHound/SharpHound (P5/P7).

## Déroulé
1. Comptes avec **SPN** (cibles Kerberoasting) :
   ```powershell
   Get-ADUser -LDAPFilter "(servicePrincipalName=*)" -Properties servicePrincipalName
   ```
2. Comptes **sans pré-auth** Kerberos (AS-REP roasting) :
   ```powershell
   Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=4194304)"
   ```
3. Membres des groupes sensibles (chemins vers Tier 0) :
   ```powershell
   Get-ADGroupMember "Domain Admins" -Recursive
   ```
4. Attribut `msDS-KeyCredentialLink` (Shadow Credentials, P5) et délégations (`msDS-AllowedToActOnBehalfOfOtherIdentity`).

## Ancrage réel
La « recon annuaire » avec un simple compte est universelle : BloodHound a popularisé la mise en
graphe de ces relations pour trouver le chemin le plus court vers Domain Admins — méthode
employée dans d'innombrables intrusions réelles.

## Résultat attendu
Identifier les objets/attributs à risque dans CORP — ce que `defend.md` apprend à réduire et surveiller.
