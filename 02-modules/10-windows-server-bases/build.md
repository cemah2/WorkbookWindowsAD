# Build — Installer et préparer Windows Server (dans CORP)

> On prépare la future VM `PAR-DC-01` (voir `01-labs/corp/architecture.md`). Ici elle n'est
> **pas encore** contrôleur de domaine : juste un serveur propre, prêt à être promu (module 13).

## Pré-requis
- Socle Phase 0 en place (Proxmox + réseau/VLAN EMEA = VLAN 10, sous-réseau `10.10.0.0/16`).
- ISO Windows Server 2019 ou 2022 (évaluation 180 j).

## Étape 1 — Créer la VM sur Proxmox
- CPU : 2 vCPU · RAM : 4 Go (GUI) · Disque : 60 Go sur le NVMe · NIC : `vmbr1`, **VLAN 10**.
- Activer l'agent QEMU (installer les *VirtIO guest tools* dans Windows ensuite).
- Monter l'ISO Windows + l'ISO VirtIO (pilotes).

## Étape 2 — Installer Windows Server
1. Choisir **Standard (Desktop Experience)** pour ce premier serveur d'apprentissage.
2. Installation personnalisée → charger le pilote disque VirtIO si le disque n'apparaît pas.
3. Définir le mot de passe administrateur local (coffre KeePass, **hors Git**).

## Étape 3 — Configuration de base (GUI)
Dans **Server Manager → Local Server**, ou via les commandes ci-dessous (PowerShell en admin).

1. **Renommer** l'hôte :
   ```powershell
   Rename-Computer -NewName "PAR-DC-01" -Restart
   ```
2. **IP statique** (adapter l'index d'interface via `Get-NetAdapter`) :
   ```powershell
   New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.10.0.10 `
     -PrefixLength 16 -DefaultGateway 10.10.0.1
   # DNS : avant promotion, pointer vers une résolution valide ; après promotion, vers lui-même
   Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 10.10.0.1
   ```
3. **Fuseau horaire & heure** :
   ```powershell
   Set-TimeZone -Id "Romance Standard Time"   # Paris
   w32tm /resync
   ```
4. **Mises à jour** (menu Windows Update ou PowerShell avec le module PSWindowsUpdate).
5. **Activer l'accès distant** : RDP (Server Manager) et WinRM :
   ```powershell
   Enable-PSRemoting -Force
   ```

## Étape 4 — (optionnel mais recommandé) découvrir Server Core
Crée une **2ᵉ VM** en mode **Server Core** et configure-la avec `sconfig` (menu texte) puis en
PowerShell à distance. C'est le mode cible pour un DC de prod.

## Vérification
```powershell
hostname                              # -> PAR-DC-01
Get-NetIPAddress -AddressFamily IPv4  # -> 10.10.0.10/16
Get-TimeZone                          # -> Romance Standard Time
Test-WSMan                            # -> WinRM répond
```

## Pièges courants
- Oublier de redémarrer après `Rename-Computer`.
- DNS client mal réglé → la promotion en DC (module 13) échouera à trouver/installer la zone.
