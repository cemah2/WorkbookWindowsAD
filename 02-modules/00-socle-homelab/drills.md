# Drills — Socle homelab

> Petits exercices de prise en main (5-15 min). But : maîtriser les gestes de base qui
> rendront tous les labs suivants sereins.

## Drill 1 — Snapshot & rollback (5 min)
- **Objectif** : savoir revenir en arrière instantanément.
- **Étapes** : crée une VM jetable → snapshot `clean` → casse quelque chose dedans
  (supprime un fichier système, change l'IP) → **rollback** sur `clean`.
- **Observer** : la VM revient à l'état exact d'avant.
- **Pourquoi** : c'est le filet de sécurité qui te permettra de tout tenter sans peur.

## Drill 2 — Clone lié vs clone complet (10 min)
- **Objectif** : comprendre l'économie de disque.
- **Étapes** : transforme une VM en **template** → crée un **clone lié** et un **clone complet** →
  compare l'espace disque consommé (`pvesm status`, taille des disques).
- **Observer** : le clone lié ne coûte presque rien au départ.
- **Pourquoi** : tu déploieras beaucoup de VM ; les clones liés évitent de saturer le NVMe.

## Drill 3 — Isolation VLAN (10 min)
- **Objectif** : prouver que GOAD-X est bien enfermé.
- **Étapes** : place une VM de test sur le **VLAN 56** → tente `ping 1.1.1.1` et
  `ping <passerelle EMEA>`.
- **Observer** : les deux doivent **échouer** tant qu'OPNsense ne route pas.
- **Pourquoi** : c'est la garantie que le lab vulnérable ne touche jamais ton réseau réel.

## Drill 4 — Déployer/détruire un range Ludus (15 min)
- **Objectif** : vivre le « lab en une commande ».
- **Étapes** : définis un range minimal (1 VM) → `ludus range deploy` → connecte-toi →
  `ludus range rm` (destruction).
- **Observer** : cycle complet create → use → destroy sans intervention manuelle sur Proxmox.
- **Pourquoi** : c'est le réflexe IaC de toutes les phases suivantes.

## Drill break-fix — Dépôt Proxmox cassé (10 min)
- **Casse** : laisse (ou remets) le dépôt *enterprise* actif sans abonnement.
- **Diagnostique** : `apt update` échoue → lis le message, identifie le dépôt fautif.
- **Répare** : bascule sur le dépôt *no-subscription*, `apt update` repasse au vert.
