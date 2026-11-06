# Attack — Ce qu'un attaquant voit d'un serveur fraîchement installé

> ⚠️ Lab isolé uniquement (voir `LEGAL.md`). Ce module est une fondation : l'objectif ici
> n'est pas une compromission complète, mais **comprendre la surface d'exposition initiale**
> d'un Windows Server avant durcissement. Les attaques AD réelles arrivent dès le module 13+.

## Contexte / pré-requis
- Depuis le poste attaquant Linux (VLAN de test), en visant la VM Windows Server du module 10.
- Le serveur est « sorti d'usine » : rôles par défaut, services d'administration activés.

## Reconnaissance de base
- **MITRE ATT&CK** : T1595 (Active Scanning), T1046 (Network Service Discovery),
  T1082 (System Information Discovery).
- **Outils** : `nmap`, `netexec` (SMB), `rdp-sec-check`.

### Déroulé
1. Balayage de ports/services :
   ```bash
   nmap -Pn -sV -p- 10.10.0.10
   ```
   Repère : 135/139/445 (SMB/RPC), 3389 (RDP), 5985/5986 (WinRM), éventuellement 53 après rôle DNS.
2. Empreinte SMB (version, signature, nom d'hôte, OS) :
   ```bash
   netexec smb 10.10.0.10
   ```
   Observe si la **signature SMB** est requise ou non, le build OS, le nom de machine.
3. Exposition RDP : niveau de chiffrement, NLA activé ou non.

## Ce que ça révèle
- La **version/édition** et le **niveau de patch** (surface de vulnérabilités connues).
- Les **services d'administration exposés** (RDP/WinRM) → cibles de *password spraying* plus tard.
- L'état de la **signature SMB** → prérequis d'un futur **relais NTLM** (module 54).

## Ancrage réel
Les intrusions commencent presque toujours par cette cartographie. De nombreux rançongiciels
(ex. familles exploitant RDP exposé et SMB non signé) démarrent exactement ainsi : repérage des
services d'admin exposés, puis *spraying* ou relais. Ce module montre pourquoi un serveur
« par défaut » est déjà bavard.

## Résultat attendu
Un inventaire des ports/services et un premier jugement de posture — qui servira de point de
comparaison avec le serveur **durci** (voir `defend.md`).
