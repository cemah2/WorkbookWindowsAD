# Attack — Pourquoi l'absence de tiering est fatale

> ⚠️ Lab isolé uniquement (voir LEGAL.md). On démontre le vol de credential latéral que le
> tiering empêche. Outils détaillés en Phase 5 (56, 57).

## Techniques visées (et bloquées par le tiering)
- **MITRE ATT&CK** : T1003 (Credential Dumping), T1550.002/003 (PtH/PtT), T1078 (Valid Accounts),
  T1021 (Remote Services).

## Déroulé (sur un domaine SANS tiering)
1. Compromission d'un poste Tier 2.
2. Un **admin de domaine s'y connecte** (ou s'y est connecté) → son TGT/hash est en mémoire (LSASS).
3. Vol du credential (Mimikatz/PtT) → authentification en tant que Domain Admin → contrôle du DC.

## Le même scénario AVEC tiering
- Le compte Tier 0 ne s'ouvre jamais sur un poste Tier 2 (deny logon + PAW) → **rien à voler**.
- Même si un credential T2 est volé, il n'ouvre rien en T0 (comptes séparés, silo).

## Ancrage réel
Le « rebond » depuis un poste vers Domain Admins via un credential admin exposé est le schéma
classique des intrusions majeures (y compris plusieurs campagnes de rançongiciels et d'APT).
Le tiering est la contre-mesure structurelle recommandée par Microsoft.

## Résultat attendu
Comprendre, par l'exemple, ce que le tiering rend impossible — et le valider via `defend.md`.
