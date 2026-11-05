# 🧭 Guide des prompts — comment piloter Claude sur ce projet

**Principe :** la mémoire vit dans le dépôt, pas dans la conversation. Une nouvelle
conversation ne se souvient de rien → on la fait **lire le dépôt** (surtout `PROJECT.md`).
Règle d'or : **une conversation = une tâche** (un module, une fiche, une solution).

---

## Étape 0 — Préparation (une seule fois)

1. Créer un **dépôt GitHub vide** (ex. `ad-windows-mastery`).
2. Avoir sous la main les 4 fichiers de spec déjà générés :
   `PROJECT.md`, `architecture.md`, `bibliographie.md`, `.gitignore`.
3. Si le dépôt est **privé** : vérifier que le connecteur GitHub de Claude a accès au dépôt
   (réglages claude.ai → Connecteurs).

---

## Conversation 1 — BOOTSTRAP

**Fichiers à joindre à CETTE conversation (et seulement celle-ci) :**
`PROJECT.md` · `architecture.md` · `bibliographie.md` · `.gitignore`

**Prompt :**
```
Attache le dépôt [OWNER/REPO].

Je démarre un projet de workbook « Expert Active Directory & Windows ». Les 4 fichiers
joints sont la spec : lis-les. Ils décrivent tout (objectif, infra, 2 labs, 10 phases,
boucle pédagogique, conventions). Contenu 100% en français, pratique avant tout.

Tâche (branche "bootstrap", PR à la fin, pas de push sur main) :
1) Commite les 4 fichiers aux bons emplacements :
   - PROJECT.md et .gitignore à la racine
   - architecture.md dans 01-labs/corp/
   - bibliographie.md dans 99-ressources/
2) Crée le squelette complet :
   00-roadmap/ (roadmap des 10 phases + carte de dépendances + suivi d'avancement)
   01-labs/{corp,goad-x}/   02-modules/   03-fiches/   04-solutions/
   05-cheatsheets/   99-ressources/   GLOSSAIRE.md   LEGAL.md   README.md
3) Crée le gabarit 02-modules/_TEMPLATE/ avec fiche.md, drills.md, build.md,
   automate/, attack.md, defend.md — chacun contenant ses sections types (vides).
Ne produis AUCUN contenu de module pour l'instant : seulement structure + spec.
Finis par la PR et un résumé de l'arborescence.
```

➡️ Après le merge, **tout est dans le dépôt**. Les conversations suivantes n'ont plus besoin
de pièces jointes : Claude lit les fichiers directement.

---

## Bloc d'en-tête réutilisable (à coller au DÉBUT de chaque conversation suivante)

```
Attache le dépôt [OWNER/REPO]. Avant toute chose, lis PROJECT.md, 01-labs/corp/architecture.md,
GLOSSAIRE.md et le gabarit 02-modules/_TEMPLATE/ pour respecter le format et les conventions.
Travaille sur une branche dédiée et ouvre une PR à la fin (jamais de push sur main).
Contenu 100% français, pratique avant tout. Confirme que tu as lu la spec, puis fais la tâche.
```

*(Aucune pièce jointe nécessaire — tout est déjà dans le dépôt.)*

---

## Conversation 2 — PHASE 0 (socle homelab)

**Pièces jointes :** aucune.
**Prompt :**
```
[BLOC D'EN-TÊTE]

Tâche : produis la Phase 0 (socle homelab) dans 01-labs/ et/ou 02-modules/00-socle/.
Je veux, pas-à-pas et testé :
- préparation de Proxmox (bonnes pratiques, templates Windows/Linux via Packer)
- plan d'adressage + VLAN conformes à architecture.md, isolation via OPNsense
- rôle du HP ProLiant (OPNsense ou Proxmox Backup Server)
- installation de Ludus sur Proxmox et déploiement de test d'un petit lab
- intro Terraform (provider Proxmox) pour préparer l'IaC des phases suivantes
- drills courts de prise en main + checklist Definition of Done
Finis par la PR.
```

---

## Conversation type — UN MODULE COMPLET (le cas le plus fréquent)

**Pièces jointes :** aucune. **Une conversation = un module.**
**Prompt :**
```
[BLOC D'EN-TÊTE]

Tâche : produis le module complet "[NN-sujet]" (ex. 11-kerberos) dans 02-modules/,
conforme au gabarit _TEMPLATE et à la boucle du PROJECT.md :
- fiche.md : concept en profondeur (schéma d'échange, ports, objets/attributs AD,
  surface d'attaque, détection, durcissement) + versioning 2016→2025 si pertinent.
- drills.md : 3 à 6 exercices isolés (5-15 min, setup minimal, hors lab complet).
- build.md : montage pas-à-pas dans CORP.
- automate/ : PowerShell d'abord, puis version IaC (Ansible/DSC).
- attack.md : exploitation dans GOAD-X, mappée MITRE ATT&CK + un lien incident/APT réel.
- defend.md : détection (Event IDs + règle Sigma) + durcissement ; idéalement rejeu
  Atomic Red Team pour prouver la détection.
Termine par un challenge sans solution, la checklist Definition of Done, et la PR.
Pour t'appuyer sur un livre : [ex. "inspire-toi des thèmes du chapitre Kerberos de
Pentesting AD"]. N'attache pas le PDF, produis de l'original.
```

---

## Conversation type — UNE FICHE TECHNIQUE seule

```
[BLOC D'EN-TÊTE]

Tâche : rédige la fiche "[protocole/techno]" dans 03-fiches/, au format standard :
rôle/utilité · fonctionnement (avec schéma d'échange) · implémentation Windows
(service, process, clés de registre) · objets/attributs AD · surface d'attaque ·
détection (Event IDs + ETW + Sigma) · durcissement · versioning 2016→2025 · pour aller
plus loin. Commite + PR.
```

---

## Conversation type — AMÉLIORATION & SOLUTION GOAD

```
[BLOC D'EN-TÊTE]

Tâche : traite la faille "[ex. AD CS ESC1]" dans 04-solutions/. Write-up détaillé :
cause racine → exploitation pas-à-pas (dans GOAD-X) → détection (Event IDs + Sigma) →
remédiation. Mappe MITRE ATT&CK. Une seule faille par conversation pour garder la qualité.
Commite + PR.
```

---

## Conversation type — CONTRÔLE QUALITÉ (toutes les quelques tâches)

```
[BLOC D'EN-TÊTE]

Tâche : relis les modules/fiches déjà produits. Vérifie : conformité au gabarit,
exactitude technique, commandes réellement exécutables, présence des drills et d'au
moins une détection par attaque, français correct, mapping ATT&CK. Liste les corrections
dans une PR sans réécrire ce qui est déjà bon.
```

---

## Conversation type — SUIVI D'AVANCEMENT

```
[BLOC D'EN-TÊTE]

Tâche : mets à jour 00-roadmap/ (coche le terminé, liste le restant) et propose les
3 prochains modules dans l'ordre logique de dépendances. Commite + PR.
```

---

## Récapitulatif « quel fichier, quand »

| Moment | Pièces jointes | But |
|---|---|---|
| Conversation 1 (bootstrap) | **les 4 fichiers de spec** | les committer dans le dépôt |
| Toutes les suivantes | **aucune** | Claude lit la spec depuis le dépôt |
| (Exceptionnel) travailler sans dépôt | `PROJECT.md` + `architecture.md` | garder le contexte |

**Rappels :** 1 conversation = 1 tâche · toujours branche + PR · tester les commandes ·
pointer les livres par thème (jamais le PDF) · ouvrir une nouvelle conversation dès que
l'actuelle devient longue (le dépôt recharge tout le contexte).
