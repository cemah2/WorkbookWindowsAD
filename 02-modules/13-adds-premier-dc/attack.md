# Attack — Reconnaissance anonyme d'un DC tout neuf

> ⚠️ Lab isolé uniquement (voir `LEGAL.md`). On ne fait pas encore d'exploitation avancée :
> on mesure ce qu'un DC **sans durcissement** divulgue à un utilisateur **non authentifié**.
> Les attaques Kerberos/NTLM complètes arrivent en Phase 5.

## Contexte / pré-requis
- `corp.meridian.com` existe avec `PAR-DC-01` (module 13).
- Poste attaquant Linux, aucune crédential valide.

## Techniques
- **MITRE ATT&CK** : T1590/T1591 (recon), T1087 (Account Discovery), T1069 (Permission Groups
  Discovery), T1482 (Domain Trust Discovery).
- **Outils** : `nmap`, `netexec`, `ldapsearch`, `enum4linux-ng`.

## Déroulé
1. Services exposés par le DC :
   ```bash
   nmap -Pn -sV -p 53,88,135,139,389,445,464,636,3268,3269 10.10.0.10
   ```
   88 = Kerberos, 389/636 = LDAP/LDAPS, 3268 = Global Catalog, 445 = SMB (SYSVOL/NETLOGON).
2. **Null / anonymous bind LDAP** — que lit-on sans compte ?
   ```bash
   ldapsearch -x -H ldap://10.10.0.10 -s base -b "" defaultNamingContext
   ldapsearch -x -H ldap://10.10.0.10 -b "DC=corp,DC=meridian,DC=com" "(objectClass=user)" sAMAccountName
   ```
   Sur un domaine ancien/mal configuré, un bind anonyme peut révéler la structure et des comptes.
3. Énumération SMB/RPC :
   ```bash
   netexec smb 10.10.0.10 -u '' -p '' --shares
   enum4linux-ng -A 10.10.0.10
   ```

## Ce que ça révèle
- Le **nom de domaine/forêt**, la politique de mot de passe, parfois la **liste d'utilisateurs**.
- La présence des partages **SYSVOL/NETLOGON** (lecture de GPO → futurs secrets en clair, ex.
  « GPP cpassword » sur domaines hérités).

## Ancrage réel
L'énumération LDAP/SMB anonyme est la première étape de la quasi-totalité des intrusions AD.
Des compromissions majeures ont commencé par la lecture de SYSVOL (mots de passe GPP) ou par
l'énumération d'utilisateurs ensuite ciblés en *password spraying*.

## Résultat attendu
Un inventaire de ce que le DC divulgue **sans authentification** — base de comparaison directe
avec `defend.md` (où l'on coupe les binds anonymes et on impose la signature LDAP).
