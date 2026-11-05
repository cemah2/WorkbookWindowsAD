# Build — Socle homelab (pas-à-pas)

> Montage réel sur ton serveur principal (Xeon E-2378G, 128 Go, Proxmox déjà installé) + le
> HP ProLiant. Les commandes shell se lancent sur le **nœud Proxmox** (SSH ou console).
> ⚠️ Certains flags d'outils évoluent — vérifie la doc officielle quand une commande diffère.

## Étape 1 — Durcir et préparer Proxmox

1. **Mises à jour sans abonnement.** Configure le dépôt *no-subscription* puis mets à jour :
   ```bash
   # Désactiver le dépôt entreprise, activer no-subscription (Debian trixie/bookworm selon version)
   # Référence : pve.proxmox.com/wiki/Package_Repositories
   apt update && apt -y dist-upgrade
   ```
2. **Stockage.** Organise tes disques selon leur rôle :
   - NVMe 2 To → stockage des **VM actives** (`local-zfs` ou LVM-thin).
   - SSD 2 To → **templates** et clones liés.
   - HDD 2 To → **sauvegardes / ISO**.
   Vérifie : `pvesm status`.
3. **Comptes.** Crée un utilisateur d'administration dédié (évite d'utiliser `root@pam` partout)
   et, pour Terraform plus tard, prépare un **token API** (Datacenter → Permissions → API Tokens).

## Étape 2 — Réseau & VLAN

Crée les bridges/VLAN conformes à `01-labs/corp/architecture.md` §12. Exemple : un bridge
principal `vmbr1` *VLAN-aware*, puis des réseaux par zone (EMEA=10, AMER=20, APAC=30,
Tier0=99, GOAD-X=56…).

1. Dans Proxmox : **Datacenter → node → System → Network** → crée un *Linux Bridge* `vmbr1`,
   coché **VLAN aware**, relié à ta carte réseau (ou en réseau interne si pas de trunk physique).
2. Chaque VM recevra une carte réseau sur `vmbr1` avec le **tag VLAN** de sa zone.
3. **Vérification** : une VM taguée VLAN 10 ne doit voir que son sous-réseau tant qu'OPNsense
   ne route pas.

## Étape 3 — OPNsense (routage + isolation)

1. Déploie **OPNsense** — soit en VM sur Proxmox (multi-NIC sur les VLAN), soit sur le **HP
   ProLiant** physique (il a une carte réseau + iLO pour la gestion).
2. Crée une interface par VLAN à router, avec son adresse de passerelle (ex. `10.10.0.1` pour EMEA).
3. **Règles de pare-feu** :
   - Autorise le routage inter-VLAN **seulement** là où c'est voulu (ex. Tier 2 → services Tier 1).
   - **Bloque toute sortie** du VLAN **56 (GOAD-X)** vers Internet et vers les autres VLAN.
4. **Vérification d'isolation** (depuis une VM du VLAN 56) :
   ```bash
   ping 1.1.1.1        # DOIT échouer
   ping 10.10.0.1      # DOIT échouer (pas de route vers EMEA)
   ```

## Étape 4 — Proxmox Backup Server (si le ProLiant ne fait pas routeur)

1. Installe **PBS** sur le ProLiant (ISO dédié) OU ajoute-le comme stockage de sauvegarde.
2. Dans Proxmox : **Datacenter → Storage → Add → Proxmox Backup Server**, renseigne l'empreinte.
3. Crée un **job de sauvegarde** planifié pour tes VM critiques.
4. **Vérification** : lance une sauvegarde, puis teste une **restauration** sur une VM jetable.

## Étape 5 — Ludus (moteur de déploiement)

Sur le nœud Proxmox :
```bash
apt update && apt -y install git
curl -s https://ludus.cloud/install | bash     # installeur interactif, accepte les défauts
```
Puis construis les templates et teste un petit range :
```bash
ludus templates build        # construit les templates (Packer) — peut être long
ludus templates list         # vérifie que les templates sont "built"
# définis un range minimal (voir docs.ludus.cloud pour le format YAML du range)
ludus range config get       # récupère/édite la config
ludus range deploy           # déploie
ludus range list             # état du range
```
**Vérification** : un range de test se déploie, tu t'y connectes (WireGuard), puis tu le détruis.

> GOAD : une fois Ludus en place, GOAD se déploie via son provider Ludus
> (`./goad.sh -p ludus` → `set_lab GOAD-Light` → `check` → `install`). Détaillé en Phase 5.

## Étape 6 — Intro Terraform (préparer l'IaC)

Objectif : prouver que Proxmox est pilotable par code (base des phases 3+). Voir
`automate/` pour un exemple minimal (`provider bpg/proxmox`, un `plan`/`apply` qui crée une VM
de test). **Vérification** : `terraform apply` crée la VM, `terraform destroy` la supprime.

## Étape 7 — Snapshots « known-good »

Une fois tout en place, prends un **snapshot** de chaque VM socle (OPNsense, PBS, Ludus) pour
pouvoir revenir à un état propre.

---

## ✅ Vérification globale

- [ ] `apt update` sans erreur de dépôt, `pvesm status` montre tes 3 stockages
- [ ] Une VM VLAN 56 ne joint ni Internet ni les autres VLAN
- [ ] Une sauvegarde PBS se restaure
- [ ] `ludus templates list` → templates *built* ; un range de test déployé/détruit
- [ ] `terraform apply/destroy` fonctionne contre Proxmox
- [ ] Snapshots pris
