# Fiche — Socle homelab (Proxmox, réseau, Ludus)

> Comprendre les briques avant de monter le lab.

## 1. Rôle & utilité

Le socle, c'est l'**hyperviseur** (qui fait tourner les VM), le **réseau** (qui les relie en
restant isolé du monde) et l'**automatisation de déploiement** (qui rend tout reproductible).
Sans socle propre, un lab devient vite ingérable (VM orphelines, pas de sauvegarde, pas d'isolation).

## 2. Composants

### Proxmox VE
Hyperviseur libre basé sur Debian + KVM/QEMU (VM) et LXC (conteneurs). Fournit : snapshots,
clones (complets ou **liés**, qui économisent le disque), templates, une API (utilisable par
Terraform), et le clustering. C'est le socle de ce homelab.

### Ludus
Plateforme open-source de **cyber range as code** bâtie **sur Proxmox**. On décrit un
environnement (VM, réseaux, rôles) dans un fichier **YAML** ; Ludus construit les templates
(via Packer), déploie et configure les VM (via Ansible), et sait déployer **GOAD** directement.
Accès aux ranges via WireGuard. C'est ce qui donne « le lab en une commande ».

### Réseau & VLAN
On segmente avec des **VLAN** (étiquettes 802.1Q) portés par des **bridges Linux** Proxmox
(`vmbrX`). Chaque zone (EMEA, AMER, APAC, Tier 0, GOAD-X…) a son VLAN et son sous-réseau,
conformément à `01-labs/corp/architecture.md` §12.

### OPNsense
Pare-feu/routeur open-source (sur le HP ProLiant ou en VM). Il **route** entre les VLAN qui
doivent communiquer et **bloque** ce qui doit rester isolé — en particulier **GOAD-X**, qui
ne doit avoir **aucune** route vers Internet ou la production.

### Proxmox Backup Server (PBS)
Serveur de sauvegarde dédié (déduplication, restauration propre). Idéal sur le ProLiant si
celui-ci ne sert pas de routeur. Permet de restaurer une VM cassée sans tout reconstruire.

## 3. Pourquoi cette approche

- **Reproductible** : tout se recrée depuis du code (Ludus/Terraform) → pas de peur de casser.
- **Isolé** : la segmentation VLAN + OPNsense protège ton réseau réel du lab vulnérable.
- **Économique** : clones liés + templates → beaucoup de VM sans exploser le disque.

## 4. Pièges courants

- Oublier de configurer le **dépôt no-subscription** de Proxmox (sinon pas de mises à jour).
- Donner par erreur une **passerelle/Internet** au VLAN GOAD-X.
- Sous-dimensionner le disque des templates Windows (prévoir large sur le SSD).

## 5. Pour aller plus loin

Docs Proxmox (`pve.proxmox.com/wiki`), Ludus (`docs.ludus.cloud`), GOAD
(`orange-cyberdefense.github.io/GOAD`). Voir `99-ressources/bibliographie.md` (P0).
