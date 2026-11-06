# Module 10 — Les bases de Windows Server (Phase 1)

Premier module de la Phase 1. Objectif : savoir **installer, configurer et durcir** une VM
Windows Server propre, qui servira de base à tout le reste (DNS, DHCP, premier DC…).

## Contenu
- `fiche.md` — éditions, Core vs Desktop Experience, rôles & fonctionnalités, versioning 2016→2025.
- `drills.md` — exercices courts (sconfig, renommage/IP en PowerShell, build number, RDP/WinRM).
- `build.md` — montage pas-à-pas de `PAR-DC-01` (base, avant promotion en DC).
- `automate/` — script PowerShell de configuration de base + notes unattend/cloud-init.
- `attack.md` — ce qu'un attaquant voit d'un serveur fraîchement installé.
- `defend.md` — baseline de durcissement initial + détection.

## Definition of Done
- [ ] Une VM Windows Server installée, nommée `PAR-DC-01`, IP statique `10.10.0.10`
- [ ] Fuseau horaire, langue/locale réglés ; RDP et WinRM maîtrisés
- [ ] Le script `automate/Set-ServerBaseline.ps1` reproduit la config de base
- [ ] Je sais lire le build number et dire quelle version/édition tourne
- [ ] Drills faits (dont le break-fix) · baseline de durcissement comprise
- [ ] Snapshot « known-good » pris avant le module suivant (11-dns)
