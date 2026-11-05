# 🪟 AD & Windows Mastery

Workbook **ultra-complet** pour devenir expert **Active Directory, Windows, sécurité,
automatisation et identité hybride (Entra)** — de débutant à expert, avec de la **pratique partout**.

> Contenu 100 % en français (termes techniques, commandes et outils en anglais).

---

## 🎯 Ce que c'est

Un parcours en **10 phases** construit autour de **deux labs** :

- **CORP** — une entreprise internationale *bien architecturée*, qu'on administre proprement
  (voir [`01-labs/corp/architecture.md`](01-labs/corp/architecture.md)).
- **GOAD-X** — un lab offensif (GOAD via Ludus) + extensions modernes, **strictement isolé**.

Chaque techno est traitée via une **boucle** : Comprendre → Drills → Construire à la main →
Automatiser → Attaquer & Défendre.

## 🗺️ Par où commencer

1. Lis [`PROJECT.md`](PROJECT.md) — la spec complète (source de vérité).
2. Lis la roadmap : [`00-roadmap/roadmap.md`](00-roadmap/roadmap.md).
3. Monte le socle : [`02-modules/00-socle-homelab/`](02-modules/00-socle-homelab/) (**Phase 0**).
4. Suis les parcours : [`00-roadmap/parcours.md`](00-roadmap/parcours.md) (Admin / Red / Blue / Hybride).

## 📂 Organisation du dépôt

```
PROJECT.md              Spec (à lire en premier)
guide-prompts.md        Comment piloter Claude (prompts prêts à l'emploi)
00-roadmap/             Roadmap, carte de dépendances, suivi, parcours
01-labs/
  corp/                 Architecture de l'entreprise de référence
  goad-x/               Lab offensif (GOAD + extensions)
02-modules/
  _TEMPLATE/            Gabarit d'un module
  NN-<sujet>/           Un module = fiche + drills + build + automate + attack + defend
03-fiches/              Fiches techniques protocole/techno
04-solutions/           Write-ups (améliorations & failles GOAD)
05-cheatsheets/         Aide-mémoire
99-ressources/          Bibliographie & références
GLOSSAIRE.md            Vocabulaire AD/Windows/sécurité
LEGAL.md                Règles d'isolation & d'éthique
```

## ⚖️ Sécurité & légal

Le lab GOAD-X est **volontairement vulnérable** → **jamais** exposé à Internet. Voir [`LEGAL.md`](LEGAL.md).

## 🔧 Infrastructure

Proxmox VE (Xeon, 128 Go) + **Ludus** · OPNsense / Proxmox Backup Server (HP ProLiant) ·
2 postes clients (Linux attaquant / Windows admin) · tenant Entra persistant pour l'hybride.
