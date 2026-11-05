# PROJECT.md — Spec du workbook « Expert Active Directory & Windows »

> **À lire en premier par toute conversation Claude travaillant sur ce dépôt.**
> Ce fichier est la source de vérité : objectifs, conventions, format des modules.
> En cas de doute, il prime sur toute hypothèse.

---

## 1. Objectif

Construire un workbook **ultra-complet** pour devenir expert Active Directory, Windows,
sécurité, automatisation et identité hybride (Entra). Public : **débutant AD** au départ,
progression jusqu'au niveau expert.

- **Langue de tout le contenu : français.** (Termes techniques, commandes et outils en anglais.)
- **Pratique partout.** Aucun sujet purement théorique : chaque techno a au minimum des
  *drills* (petits exercices isolés) et, quand c'est pertinent, un lab complet.

## 2. Profil & infrastructure

- Serveur principal : Xeon E-2378G, 128 Go RAM, **Proxmox VE** + **Ludus** (déploiement des ranges).
- HP ProLiant (16 Go) : **OPNsense** (routeur/isolation) ou **Proxmox Backup Server**.
- 2 postes clients (Linux = attaquant, Windows = admin/analyste).
- Cloud : **A Cloud Guru** pour du jetable ; **tenant Entra persistant** (gratuit/essai) pour l'hybride.

## 3. Deux labs

- **CORP** : entreprise internationale *bien architecturée*, qu'on administre proprement.
  Design complet dans `01-labs/corp/architecture.md` (forêt unique `corp.meridian.com`, sites
  EMEA/AMER/APAC + RODC Lyon, tiering Enterprise Access Model, forêt M&A `nimbus.local`).
- **GOAD-X** : lab offensif (GOAD via Ludus) + extensions modernes. **Strictement isolé.**

## 4. La boucle pédagogique (appliquée à CHAQUE techno)

1. **Comprendre** → `fiche.md` (volet académique)
2. **Drills** → `drills.md` (3-6 exercices isolés de 5-15 min, setup minimal, jouables hors lab)
3. **Construire à la main** → `build.md` (dans CORP)
4. **Automatiser** → `automate/` (d'abord PowerShell, puis IaC : DSC / Ansible / Terraform)
5. **Attaquer & Défendre** → `attack.md` + `defend.md` (exploit dans GOAD-X, puis détection
   **Event IDs + règle Sigma** et durcissement). Toute technique **mappée à MITRE ATT&CK**.

## 5. Roadmap — 10 phases

- **P0** Socle homelab (Proxmox, réseaux isolés, Ludus, OPNsense, PBS, intro Terraform)
- **P1** Fondations Windows & AD (install, DNS/DHCP, 1er DC, objets ; manuel → PowerShell)
- **P2** Administration (GPO, tiering, délégation, LAPS, DFS, sites/réplication, RODC, FSMO, PRA)
- **P3** Automatisation avancée (PowerShell, DSC, Ansible, Terraform → lab en 1 commande)
- **P4** PKI / AD CS (PKI 2 niveaux propre → attaques ESC1-ESC16)
- **P5** Offensif on-prem (Kerberos, délégations/RBCD, coercition/relais NTLM, Shadow Creds,
  dump creds, persistance ; forêt M&A & cross-forest)
- **P6** Hybride / Entra (Entra Connect, hybrid join, SSO ; attaques hybrides ; CA/PIM)
- **P7** Blue team / détection (SIEM, Sysmon, Sigma par attaque, threat hunting, purple team)
- **P8** Internals & évasion — orienté **compréhension & détection**, pas production d'outils offensifs
- **P9** Capstone + nouveautés **Server 2025** (niveau fonctionnel 2025, dMSA & escalade associée)

## 6. Les trois volets demandés + extensions

- **Pratique** (build + drills), **Solutions** (`04-solutions/`), **Académique** (`fiche.md`),
  **Fiches techno/protocole** (`03-fiches/`).
- **Extensions qualité (à appliquer partout) :**
  - Chaque phase : un **challenge sans solution** + une **checklist « je sais faire sans aide »**.
  - **Purple team prouvé** : rejouer via Atomic Red Team / Caldera, et **valider** la règle Sigma.
  - **Reporting** : templates rapport de pentest + remédiation + **journal de bord** de lab.
  - **Ancrage réel** : relier chaque attaque à un incident/APT réel + entrée ATT&CK.
  - **Drills break-fix** : lab volontairement cassé à diagnostiquer (`dcdiag`, `repadmin`, `klist`).
  - **Audit de l'existant** : **PingCastle / Purple Knight**, score suivi dans le temps.
  - **BloodHound défensif** sur CORP : fermer les chemins vers le Tier 0.
  - **Attaquer la cible durcie** (CORP) pour voir les contrôles *tenir*.
  - **Versioning** : marquer le comportement 2016 → 2019 → 2022 → 2025 + ce qui est **déprécié**
    (NTLM, WSUS, WMIC).
  - **Rétention** : générer un deck **Anki** depuis les fiches.

## 7. Format d'un module (`02-modules/NN-<sujet>/`)

```
fiche.md     drills.md     build.md     automate/     attack.md     defend.md
```
Gabarit vide de référence : `02-modules/_TEMPLATE/`. Tout module s'y conforme.

## 8. Conventions

- Branche dédiée par tâche + **Pull Request** ; **jamais de push direct sur `main`**.
- Commandes **réellement exécutables** et testées dans le lab ; fournir la commande de vérif.
- **Livres** : ne jamais joindre de PDF (voir `.gitignore`). Pointer un sujet/chapitre ; le
  contenu produit est **original**. Références dans `99-ressources/bibliographie.md`.
- **Definition of Done** d'un module : fiche complète + drills jouables + lab monté + au moins
  **une détection prouvée** + technique(s) mappée(s) ATT&CK + checklist cochée.
- Navigation : maintenir `GLOSSAIRE.md`, la carte de dépendances dans `00-roadmap/`, et des
  parcours par objectif (Admin / Red / Blue / Hybride).
- **Sécurité/légal** : GOAD-X est volontairement vulnérable → jamais exposé (voir `LEGAL.md`).

## 9. Cadence

Objectif réaliste : ~**1 module par semaine**. Mieux vaut tenable et terminé que vaste et abandonné.
Suivi d'avancement tenu à jour dans `00-roadmap/`.

## 10. Portée des améliorations GOAD (pour `04-solutions/`)

AD CS (ESC1-ESC16), RBCD, coercition + relais NTLM, Shadow Credentials, hybride Entra,
nouveautés Server 2025 (dMSA). Chaque faille : cause racine → exploitation pas-à-pas →
détection → remédiation.
