# Attack — Tester les détections (perspective rouge)

> ⚠️ Lab isolé uniquement. Ici l'« attaque » sert à **valider** les règles (purple).

## Principe
Chaque règle Sigma doit être **déclenchée** par l'attaque qu'elle cible. On rejoue les techniques des
phases 4-6 et on vérifie l'alerte. Les techniques qui **ne déclenchent rien** = angles morts.

## Mapping attaque → règle (extrait)
- Kerberoasting (52) → `kerberoasting.yml`
- RBCD (53) → `rbcd-write.yml`
- ESC8 (43/54) → `adcs-machine-cert.yml`
- Dump LSASS (56) → `lsass-access.yml`
- DCSync (26/56) → `dcsync.yml`
- Clear log (70) → `security-log-cleared.yml`

## Évasion (à documenter)
Certaines variantes (AES Kerberoasting, dump LSASS « discret », ETW patch) peuvent échapper aux règles
naïves → affiner (module 74) ou compléter par EDR.

## Ancrage réel
La validation par rejeu (Atomic Red Team/Caldera) est la pratique standard du detection engineering :
on ne « croit » pas une règle, on la **prouve**.

## Résultat attendu
Une matrice de couverture ATT&CK à jour (`coverage.md`) avec le statut « prouvée » par règle.
