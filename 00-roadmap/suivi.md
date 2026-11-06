# ✅ Suivi d'avancement

Cadence cible : **~1 module / semaine**. Un module est *terminé* quand sa **Definition of Done**
est cochée (fiche + drills + build + ≥1 détection prouvée + mapping ATT&CK + checklist).

Légende : ⬜ à faire · 🟨 en cours · ✅ terminé

## Phase 0 — Socle homelab
- 🟨 `00-socle-homelab` (contenu initial produit — à exécuter et valider sur ton Proxmox)

## Phase 1 — Fondations
- ✅ `10-windows-server-bases` (produit — à exécuter/valider sur le lab)
- ✅ `11-dns` (produit — à exécuter/valider sur le lab)
- ✅ `12-dhcp` (produit — à exécuter/valider sur le lab)
- ✅ `13-adds-premier-dc` (produit — à exécuter/valider sur le lab)
- ✅ `14-objets-ad` (produit — à exécuter/valider sur le lab)
- ✅ `15-ldap-bases` (produit — à exécuter/valider sur le lab)
- ✅ `16-kerberos-intro` (produit — à exécuter/valider sur le lab)
- ✅ `17-ntlm-intro` (produit — à exécuter/valider sur le lab)

## Phase 2 — Administration
- ✅ `20-gpo` (produit — à exécuter/valider sur le lab) · ⬜ `21-ou-delegation` · ⬜ `22-tiering-eam` · ⬜ `23-groupes-agdlp`
- ✅ `24-laps` (produit — à exécuter/valider sur le lab) · ⬜ `25-dfs` · ⬜ `26-sites-replication` · ⬜ `27-rodc`
- ✅ `28-fsmo` (produit — à exécuter/valider sur le lab) · ⬜ `29-sauvegarde-pra`

## Phase 3 — Automatisation
- ✅ `30-powershell-fondamentaux` (produit — à exécuter/valider sur le lab) · ⬜ `31-powershell-remoting` · ⬜ `32-dsc`
- ✅ `33-ansible-windows` (produit — à exécuter/valider sur le lab) · ⬜ `34-terraform-iac` · ⬜ `35-corp-en-une-commande`

## Phase 4 — PKI / AD CS
- ✅ `40-pki-conception` (produit — à exécuter/valider sur le lab) · ⬜ `41-adcs-deploiement` · ⬜ `42-templates-certificats` · ⬜ `43-adcs-esc`

## Phase 5 — Offensif on-prem
- ✅ `50-methodologie` (produit — à exécuter/valider sur le lab) · ⬜ `51-recon-enumeration` · ⬜ `52-kerberoasting-asrep`
- ✅ `53-delegations-rbcd` (produit — à exécuter/valider sur le lab) · ⬜ `54-coercition-ntlm-relay` · ⬜ `55-shadow-credentials`
- ✅ `56-dump-credentials` (produit — à exécuter/valider sur le lab) · ⬜ `57-persistance` · ⬜ `58-cross-forest`

## Phase 6 — Hybride / Entra
- ✅ `60-entra-fondamentaux` (produit — à exécuter/valider sur le lab) · ⬜ `61-entra-connect` · ⬜ `62-hybrid-join-sso`
- ⬜ `63-attaques-hybrides` · ⬜ `64-conditional-access-pim`

## Phase 7 — Blue team
- ⬜ `70-collecte-logs-siem` · ⬜ `71-sysmon` · ⬜ `72-sigma-par-attaque`
- ⬜ `73-threat-hunting` · ⬜ `74-purple-team`

## Phase 8 — Internals & évasion
- ⬜ `80-windows-internals` · ⬜ `81-tokens-privileges` · ⬜ `82-lsass-dpapi`
- ⬜ `83-etw-amsi` · ⬜ `84-edr-comprehension-detection`

## Phase 9 — Capstone
- ⬜ `90-capstone-scenario` · ⬜ `91-server-2025-nouveautes`
