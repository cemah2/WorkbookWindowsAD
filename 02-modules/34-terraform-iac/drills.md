# Drills — Terraform

## Drill 1 — plan avant apply (10 min)
- **Étapes** : écris une resource VM minimale, `terraform plan`, lis le diff.
- **Observer** : ce que Terraform compte créer.
- **Pourquoi** : toujours prévoir avant d'appliquer.

## Drill 2 — apply/destroy (10 min)
- **Étapes** : `apply` crée une VM de test, `destroy` la supprime.
- **Pourquoi** : le cycle de vie complet, reproductible.

## Drill 3 — for_each (10 min)
- **Étapes** : provisionne 2-3 VM via `for_each` sur une map.
- **Pourquoi** : scaler sans copier-coller.

## Drill 4 — state (10 min)
- **Étapes** : `terraform state list`, `terraform state show <res>`.
- **Observer** : le state reflète le réel.
- **Pourquoi** : comprendre que le state est la source de vérité (à protéger).

## Drill break-fix — dérive hors Terraform (10 min)
- **Casse** : modifie/supprime une VM directement dans Proxmox (hors Terraform).
- **Diagnostique** : `terraform plan` montre une dérive.
- **Répare** : `apply` (reconverge) ou `terraform refresh`/import ; comprends le rôle du state.
