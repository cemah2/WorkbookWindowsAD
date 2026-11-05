# 🏴 GOAD-X — Lab offensif

Lab **volontairement vulnérable** basé sur **GOAD** (Game of Active Directory, Orange
Cyberdefense), déployé via **Ludus** sur Proxmox, **strictement isolé** (VLAN 56 derrière OPNsense).

> ⚠️ Voir `LEGAL.md`. Jamais exposé à Internet ni à un réseau de production.

## Déploiement (résumé — détaillé en Phase 0 puis Phase 5)

Ludus déploie GOAD depuis un fichier de config YAML. Variantes disponibles : `GOAD` (complet,
5 VM / 2 forêts / 3 domaines), `GOAD-Light`, `MINILAB`, `SCCM`, `NHA`, `DRACARYS`.

```bash
# sur le nœud Proxmox, après installation de Ludus (voir 02-modules/00-socle-homelab)
git clone https://github.com/Orange-Cyberdefense/GOAD.git
cd GOAD
./goad.sh -p ludus
# puis dans le prompt GOAD :
#   set_lab GOAD-Light   # commencer petit
#   check
#   install
```

## Extensions prévues (voir `04-solutions/`)

AD CS (ESC1-ESC16), RBCD, coercition + relais NTLM, Shadow Credentials, hybride Entra,
nouveautés Server 2025 (dMSA). Chaque extension = un write-up dans `04-solutions/`.

## Snapshots

Faire un snapshot **`clean-setup`** juste après l'installation (via Ludus ou Proxmox) pour
pouvoir rejouer les attaques depuis un état propre.
