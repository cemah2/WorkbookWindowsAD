# Drills — CORP en une commande

## Drill 1 — Destroy → Deploy (20 min)
- **Étapes** : détruis une partie du lab, relance `deploy-corp.sh`, vérifie le retour à l'identique.
- **Pourquoi** : c'est LA compétence (infra jetable et reproductible).

## Drill 2 — Hand-off Terraform → Ansible (15 min)
- **Étapes** : après `terraform apply`, génère l'inventaire depuis les outputs, ping Ansible.
- **Pourquoi** : comprendre la jointure provisioning/config.

## Drill 3 — Idempotence globale (10 min)
- **Étapes** : relance le pipeline complet sans rien détruire.
- **Observer** : peu/pas de changements (convergence).
- **Pourquoi** : valider que tout est idempotent.

## Drill 4 — Changer l'architecture par le code (15 min)
- **Étapes** : ajoute une VM membre dans le `.tf` + un play Ansible, redéploie.
- **Pourquoi** : faire évoluer CORP par le code, pas à la main.

## Drill break-fix — Séquencement cassé (15 min)
- **Casse** : lance la config des membres avant la promotion du DC.
- **Diagnostique** : jonction au domaine échoue (DC injoignable) ; lis les erreurs Ansible.
- **Répare** : ajoute `wait_for_connection`/dépendances, rejoue dans l'ordre.
