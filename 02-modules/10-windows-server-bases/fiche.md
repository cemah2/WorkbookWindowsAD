# Fiche — Windows Server : bases & préparation

> Volet académique. Avant de créer un domaine, il faut un serveur Windows **installé,
> nommé, adressé et à jour**. Ce module pose ces fondations.

## 1. Rôle & utilité

Windows Server est le système qui héberge les **rôles** d'infrastructure (AD DS, DNS, DHCP,
fichiers, etc.). Un rôle = un ensemble de services qu'on *ajoute* à un serveur. Avant tout
rôle, on prépare une base saine : nom d'hôte stable, IP fixe, horloge correcte, mises à jour.

## 2. Éditions & modes d'installation

### Éditions
- **Standard** : la plupart des rôles ; convient au lab.
- **Datacenter** : virtualisation illimitée, fonctions avancées (Storage Spaces Direct…).

### Deux « expériences » d'installation
| Mode | Description | Quand l'utiliser |
|---|---|---|
| **Server Core** | Sans interface graphique, administration en ligne de commande/à distance | Recommandé en prod : surface d'attaque réduite, moins de RAM, moins de patches |
| **Desktop Experience (GUI)** | Interface graphique complète (Server Manager, consoles MMC) | Pour apprendre et pour les rôles qui exigent une GUI |

> **Dans ce workbook** : on apprend d'abord en **GUI** (plus visuel), puis on bascule en
> **Core + administration à distance** pour adopter la bonne pratique. Les DC de prod se font
> idéalement en Core.

## 3. Cycle de vie & versions

| Version | Niveau fonctionnel AD introduit | Notes |
|---|---|---|
| 2016 | 2016 | Dernier FL avant 2025 |
| 2019 | (2016) | Améliorations sécurité/opérationnelles |
| 2022 | (2016) | Secured-core, TLS 1.3 |
| **2025** | **2025** | Nouveau FL, dMSA, 32K pages, NUMA ; **NTLM/WSUS dépréciés** |

> On démarrera CORP en **2016/2019** pour voir la base, puis on fera évoluer vers **2025** en
> Phase 9 pour observer l'évolution de la surface d'attaque.

## 4. Préparation de base (ce que fait `build.md`)

1. **Nom d'hôte** stable (`PAR-DC-01`…) — à fixer **avant** toute promotion de rôle.
2. **IP statique** + DNS pointant correctement (un DC doit avoir une IP fixe).
3. **Fuseau horaire / heure** : Kerberos tolère ≤ 5 min d'écart → l'heure juste est critique.
4. **Mises à jour** et activation.
5. **Pare-feu** et accès d'administration à distance (WinRM/RDP).

## 5. Outils d'administration

- **Server Manager** (GUI) : ajout de rôles, vue d'ensemble.
- **PowerShell** : `Install-WindowsFeature`, `Rename-Computer`, `New-NetIPAddress`… (c'est la
  voie qu'on automatisera).
- **Windows Admin Center / RSAT** : administration centralisée et à distance (utile pour Core).
- **sconfig** : menu texte de configuration rapide sur Server Core.

## 6. Pièges courants

- Promouvoir un DC **avant** d'avoir fixé le nom d'hôte → renommer un DC ensuite est risqué.
- Laisser l'IP en **DHCP** sur un futur DC.
- Négliger l'**heure** → authentifications Kerberos qui échouent plus tard.

## 7. Versioning (2016 → 2025)

Voir §3. Retiens surtout : **WSUS et NTLM sont dépréciés en 2025** (prévoir Azure Update
Manager / Windows Update for Business côté patching, et une stratégie de réduction NTLM).

## 8. Pour aller plus loin

*Mastering Active Directory* (ch. installation/conception), docs Microsoft Learn — Windows
Server. Voir `99-ressources/bibliographie.md` (P1).
