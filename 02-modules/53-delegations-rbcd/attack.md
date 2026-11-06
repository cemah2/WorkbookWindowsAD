# Attack — Délégations & RBCD (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1558 (Kerberos), T1134 (Access Token Manipulation / impersonation),
  T1098 (Account Manipulation — écriture d'attribut).
- **Outils** : impacket (findDelegation, addcomputer, rbcd, getST), Rubeus, PowerView.

## Chaîne RBCD (moderne)
1. Recon : cible avec ACL GenericWrite (ou quota machine > 0).
2. `addcomputer` → compte machine contrôlé (`EVIL$`).
3. `rbcd -action write` → délégation EVIL$ → TARGET$.
4. `getST -impersonate Administrator` → ticket admin vers la cible → `psexec -k`.

## Unconstrained + coercition (module 54)
Machine unconstrained compromise → `Rubeus monitor` → coercer un DC (PetitPotam) → **TGT du DC** →
DCSync → domaine.

## Ancrage réel
RBCD (SpecterOps) et unconstrained+coercition sont des escalades très prisées : elles transforment
une simple ACL ou un service mal configuré en contrôle du domaine.

## Résultat attendu
Accès admin sur une cible (RBCD) ou TGT de DC (unconstrained) → à neutraliser (`defend.md`).
