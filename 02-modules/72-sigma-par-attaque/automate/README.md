# Automate — Sigma
`rules/` : règles Sigma consolidées (phases 4-6), une par fichier, taguées ATT&CK.
`convert-all.sh` : convertit toutes les règles vers un backend. `coverage.md` : matrice ATT&CK.
## Usage
```bash
./convert-all.sh elasticsearch ecs_windows
sigma check rules/*.yml
```
