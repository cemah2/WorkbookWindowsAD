# Attack — Abus d'ACL & de délégation

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Exploitation outillée détaillée en Phase 5.

## Techniques
- **MITRE ATT&CK** : T1222 (Permissions Modification), T1098 (Account Manipulation),
  T1484 (Domain Policy Modification).
- **Outils** : BloodHound/SharpHound (ACL edges), PowerView (`Add-DomainObjectAcl`,
  `Set-DomainUserPassword`), Whisker (Shadow Creds via `msDS-KeyCredentialLink`).

## Déroulé
1. **Cartographier les ACL** avec BloodHound : chercher les edges *GenericAll*, *WriteDACL*,
   *WriteOwner*, *ForceChangePassword*, *AddKeyCredentialLink* vers des cibles sensibles.
2. **Exploiter une ACL** (exemples, P5) :
   - *ForceChangePassword* → réinitialiser le mot de passe d'une cible.
   - *WriteDACL* → s'octroyer GenericAll puis prendre le contrôle.
   - *AddKeyCredentialLink* → Shadow Credentials → auth en tant que la cible.

## Ancrage réel
L'analyse de graphe d'ACL (BloodHound) a transformé l'offensive AD : des chemins invisibles à
l'œil (une délégation oubliée) deviennent des autoroutes vers Domain Admins. Technique omniprésente
en intrusion réelle.

## Résultat attendu
Lister les ACL abusables de CORP (surtout vers le Tier 0) — à refermer via `defend.md`.
