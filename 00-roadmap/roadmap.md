# 🗺️ Roadmap — 10 phases

Progression **débutant → expert**. Chaque techno suit la boucle du `PROJECT.md` :
**Comprendre → Drills → Construire à la main → Automatiser → Attaquer & Défendre.**

| Phase | Thème | Objectif principal | Labs |
|---|---|---|---|
| **P0** | Socle homelab | Proxmox, réseaux isolés, Ludus, OPNsense, PBS, intro Terraform | — |
| **P1** | Fondations Windows & AD | Install, DNS/DHCP, 1er DC, objets ; manuel → PowerShell | CORP |
| **P2** | Administration | GPO, tiering, délégation, LAPS, DFS, sites/réplication, RODC, FSMO, PRA | CORP |
| **P3** | Automatisation avancée | PowerShell, DSC, Ansible, Terraform → lab en 1 commande | CORP |
| **P4** | PKI / AD CS | PKI 2 niveaux propre → attaques ESC1-ESC16 | CORP + GOAD-X |
| **P5** | Offensif on-prem | Kerberos, délégations/RBCD, coercition/relais NTLM, Shadow Creds, persistance, cross-forest | GOAD-X |
| **P6** | Hybride / Entra | Entra Connect, hybrid join, SSO ; attaques hybrides ; CA/PIM | CORP + Entra |
| **P7** | Blue team / détection | SIEM, Sysmon, Sigma par attaque, threat hunting, purple team | Les deux |
| **P8** | Internals & évasion | Internals Windows, EDR — orienté compréhension & détection | CORP |
| **P9** | Capstone + Server 2025 | Scénario complet + niveau fonctionnel 2025, dMSA | Les deux |

---

## Détail des modules envisagés (indicatif, à affiner au fil de l'eau)

### P0 — Socle homelab ✅ (produit)
- `00-socle-homelab` : Proxmox, réseau/VLAN, OPNsense, PBS, Ludus, intro Terraform.

### P1 — Fondations
- `10-windows-server-bases`, `11-dns`, `12-dhcp`, `13-adds-premier-dc`, `14-objets-ad`,
  `15-ldap-bases`, `16-kerberos-intro`, `17-ntlm-intro`.

### P2 — Administration
- `20-gpo`, `21-ou-delegation`, `22-tiering-eam`, `23-groupes-agdlp`, `24-laps`,
  `25-dfs`, `26-sites-replication`, `27-rodc`, `28-fsmo`, `29-sauvegarde-pra`.

### P3 — Automatisation
- `30-powershell-fondamentaux`, `31-powershell-remoting`, `32-dsc`, `33-ansible-windows`,
  `34-terraform-iac`, `35-corp-en-une-commande`.

### P4 — PKI / AD CS
- `40-pki-conception`, `41-adcs-deploiement`, `42-templates-certificats`, `43-adcs-esc`.

### P5 — Offensif on-prem
- `50-methodologie`, `51-recon-enumeration`, `52-kerberoasting-asrep`, `53-delegations-rbcd`,
  `54-coercition-ntlm-relay`, `55-shadow-credentials`, `56-dump-credentials`,
  `57-persistance`, `58-cross-forest`.

### P6 — Hybride / Entra
- `60-entra-fondamentaux`, `61-entra-connect`, `62-hybrid-join-sso`,
  `63-attaques-hybrides`, `64-conditional-access-pim`.

### P7 — Blue team
- `70-collecte-logs-siem`, `71-sysmon`, `72-sigma-par-attaque`, `73-threat-hunting`,
  `74-purple-team`.

### P8 — Internals & évasion
- `80-windows-internals`, `81-tokens-privileges`, `82-lsass-dpapi`, `83-etw-amsi`,
  `84-edr-comprehension-detection`.

### P9 — Capstone
- `90-capstone-scenario`, `91-server-2025-nouveautes`.

---

Voir aussi : [`carte-dependances.md`](carte-dependances.md) · [`suivi.md`](suivi.md) ·
[`parcours.md`](parcours.md).
