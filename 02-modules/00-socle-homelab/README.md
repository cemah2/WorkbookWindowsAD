# Module 00 — Socle homelab (Phase 0)

Objectif : préparer une base **propre, isolée et reproductible** pour tous les labs suivants.
À la fin, tu peux déployer et détruire des VM à la demande, et GOAD est déployable en une commande.

## Contenu
- `fiche.md` — concepts : virtualisation, Proxmox, Ludus, réseau/VLAN, isolation.
- `drills.md` — petits exercices de prise en main (snapshots, clone, VLAN, ping-test).
- `build.md` — montage pas-à-pas : Proxmox → réseau/OPNsense → PBS → Ludus → Terraform.
- `automate/` — intro IaC : exemple Terraform (provider Proxmox) + notes Ludus.

## Definition of Done (Phase 0)
- [ ] Proxmox à jour, dépôt no-subscription configuré, stockage organisé (NVMe/SSD/HDD)
- [ ] Réseaux/VLAN créés conformément à `01-labs/corp/architecture.md` §12
- [ ] OPNsense opérationnel (routage + isolation), GOAD-X **sans** route vers Internet/prod
- [ ] Proxmox Backup Server joignable (ou rôle PBS assumé par le ProLiant)
- [ ] Ludus installé, `ludus templates build` réussi, un petit range de test déployé puis détruit
- [ ] Un `plan`/`apply` Terraform minimal fonctionne contre Proxmox
- [ ] Snapshots « known-good » pris
