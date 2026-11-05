# 📚 Bibliographie & Ressources de référence

> **Règle du dépôt :** on met ici les **références**, jamais les fichiers (PDF/EPUB).
> Les ouvrages sont sous droit d'auteur — ils restent en local, hors du dépôt
> (voir `.gitignore`). Pour qu'un contenu s'appuie sur un livre, il suffit de
> pointer le sujet/chapitre dans le prompt du module ; le contenu produit est original.

Légende des phases :
`P0` socle homelab · `P1` fondations AD · `P2` administration · `P3` automatisation ·
`P4` PKI/AD CS · `P5` offensif on-prem · `P6` hybride/Entra · `P7` blue team/détection ·
`P8` internals & évasion · `P9` capstone/Server 2025

---

## 1. Tes livres (collection de départ)

| Livre | Auteur | Éditeur | Sert surtout pour |
|---|---|---|---|
| Windows Security Internals | James Forshaw | No Starch | P4, P8 (fiches internals, sécurité Windows) |
| Evasive Malware | Kyle Cucci | No Starch | P8 (compréhension/détection des évasions) |
| Evading EDR | Matt Hand | No Starch | P8 (fonctionnement EDR, télémétrie, détection) |
| Pentesting Active Directory and Windows-based Infrastructure | Denis Isakov | Packt | P5, P6 (offensif AD & hybride) |
| Mastering Active Directory (3e éd., Server 2022) | Dishan Francis | Packt | P1, P2 (conception, déploiement, admin) |
| Mastering PowerShell Scripting (4e éd., PS 7.1) | Chris Dent | Packt | P3 (automatisation) |
| Windows Internals (Part 1 7e éd. / Part 2) | Russinovich, Allievi, Ionescu, Solomon | MS Press | P8 (noyau, processus, sécurité) |

---

## 2. Livres complémentaires recommandés

### Administration & conception AD / Windows Server
- **Active Directory** — Brian Desmond et al. (O'Reilly) — référence classique, concepts durables. → P1, P2
- **Windows Server 2022 & PowerShell All-in-One for Dummies** — Sara Perrott — vue d'ensemble pratique. → P1-P3

### PowerShell & automatisation
- **Learn PowerShell in a Month of Lunches** — Don Jones & Jeffrey Hicks — meilleur point de départ débutant. → P3
- **Learn PowerShell Scripting in a Month of Lunches** — Don Jones & Jeffrey Hicks — passage au scripting. → P3
- **PowerShell for Sysadmins** — Adam Bertram (No Starch) — automatisation orientée admin. → P3

### Sécurité offensive (red team)
- **The Hacker Playbook 3** — Peter Kim — méthodologie d'attaque pratique. → P5
- **Cybersecurity Attacks – Red Team Strategies** — Johann Rehberger (Packt) — monter/piloter une red team. → P5, P7
- **RTFM: Red Team Field Manual** — Clark & Downer — aide-mémoire commandes. → P5

### Cloud & hybride
- **Pentesting Azure Applications** — Matt Burrough (No Starch) — offensif Azure/Entra. → P6
- **Exam Ref AZ-500 Azure Security Technologies** (MS Press) — durcissement/sécurité Azure. → P6
- **Exam Ref SC-300 Microsoft Identity and Access Administrator** (MS Press) — identité Entra. → P6

### Détection, forensics & malware (blue / internals)
- **Practical Malware Analysis** — Sikorski & Honig (No Starch) — analyse statique/dynamique. → P8
- **The Art of Memory Forensics** — Ligh, Case, Levy, Walters — mémoire/LSASS. → P7, P8
- **BTFM: Blue Team Field Manual** — Alan White & Ben Clark — aide-mémoire défense. → P7

---

## 3. Documentation officielle (gratuite, à jour)

- **Microsoft Learn — Active Directory Domain Services** : `https://learn.microsoft.com/windows-server/identity/ad-ds/` → P1, P2
- **Microsoft Learn — Windows Server (what's new 2025)** : `https://learn.microsoft.com/windows-server/get-started/whats-new-windows-server-2025` → P9
- **Microsoft Learn — PowerShell** : `https://learn.microsoft.com/powershell/` → P3
- **Microsoft Learn — Microsoft Entra ID** : `https://learn.microsoft.com/entra/` → P6
- **Securing Privileged Access / Enterprise Access Model** (modèle de tiering) : `https://learn.microsoft.com/security/privileged-access-workstations/overview` → P2
- **Best Practices for Securing Active Directory** : `https://learn.microsoft.com/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory` → P2, P7
- **Windows LAPS** : `https://learn.microsoft.com/windows-server/identity/laps/laps-overview` → P2
- **AD CS – PKI design** : `https://learn.microsoft.com/windows-server/identity/ad-cs/` → P4
- **Microsoft Defender for Identity** : `https://learn.microsoft.com/defender-for-identity/` → P7

---

## 4. Sites & blogs de référence

### Sécurité AD (offensif + défensif)
- **The Hacker Recipes** (Charlie Bromberg) — `https://www.thehacker.recipes/` — LA référence attaques AD, par technique. → P5, P6
- **ADSecurity.org** (Sean Metcalf) — `https://adsecurity.org/` — fond de référence AD security. → P5, P7
- **Trimarc Security blog** — `https://www.hub.trimarcsecurity.com/` — durcissement AD concret. → P2, P7
- **SpecterOps blog** — `https://posts.specterops.io/` — BloodHound, AD CS, délégations. → P4, P5
- **HackTricks — Windows/AD** — `https://book.hacktricks.xyz/windows-hardening/active-directory-methodology` — méthodo exhaustive. → P5
- **Semperis blog** — `https://www.semperis.com/blog/` — attaques & défense AD/Entra. → P5, P7

### Hybride / Entra ID (incontournables)
- **dirkjanm.io** (Dirk-jan Mollema) — `https://dirkjanm.io/` — référence attaques Entra/Azure AD & hybride. → P6
- **AADInternals / o365blog** (Nestori Syynimaa) — `https://aadinternals.com/` — outil + articles Entra. → P6

### PKI / AD CS
- **"Certified Pre-Owned"** (SpecterOps) — whitepaper fondateur des attaques ESC. → P4
- **Certipy wiki** — `https://github.com/ly4k/Certipy` — exploitation ESC pas-à-pas. → P4

---

## 5. Aide-mémoire & recueils (cheat sheets)

- **PayloadsAllTheThings** — `https://github.com/swisskyrepo/PayloadsAllTheThings` (voir Active Directory Attack.md) → P5
- **The Hacker Recipes – AD cheatsheets** → P5
- **LOLBAS** (binaires Windows détournables) — `https://lolbas-project.github.io/` → P5, P7
- **Active Directory Exploitation Cheat Sheet** (plusieurs sur GitHub) → P5
- **Kerberos attacks cheat sheet** → P5

---

## 6. Outils

### Reconnaissance & offensif
| Outil | Usage | Phase |
|---|---|---|
| BloodHound / SharpHound (CE) | Cartographie des chemins d'attaque AD | P5, P7 |
| PowerView / PowerSploit | Énumération AD | P5 |
| impacket (suite) | secretsdump, ntlmrelayx, GetUserSPNs… | P5 |
| NetExec (ex-CrackMapExec) | Balayage/exploitation SMB/LDAP/WinRM | P5 |
| Rubeus | Attaques Kerberos (roasting, delegation, PtT) | P5 |
| Kerbrute | Spray/énum d'utilisateurs Kerberos | P5 |
| Certify / Certipy | Attaques AD CS (ESC) | P4 |
| Whisker / pywhisker | Shadow Credentials (msDS-KeyCredentialLink) | P5 |
| Responder | Empoisonnement LLMNR/NBT-NS, capture NTLM | P5 |
| Coercer / PetitPotam | Coercition d'authentification | P5 |
| Mimikatz | Extraction de secrets (lab uniquement) | P5, P8 |
| Hashcat / John | Cassage de hashes/tickets | P5 |
| AADInternals / ROADtools | Reconnaissance & attaques Entra | P6 |

### Défensif & détection
| Outil | Usage | Phase |
|---|---|---|
| Sysmon (+ config SwiftOnSecurity) | Télémétrie endpoint détaillée | P7 |
| Wazuh ou Elastic/ELK | SIEM, centralisation des logs | P7 |
| Sigma + pySigma | Règles de détection *as code* | P7 |
| PingCastle | Audit/score de posture AD | P2, P7 |
| Purple Knight (Semperis) | Audit AD/Entra, indicateurs d'exposition | P7 |
| Atomic Red Team | Rejouer des techniques ATT&CK | P7 |
| MITRE Caldera | Émulation d'adversaire automatisée | P7 |
| Velociraptor | Chasse & réponse à incident | P7 |
| BloodHound (usage défensif) | Fermer les chemins vers le Tier 0 | P7 |

### Automatisation & infrastructure
| Outil | Usage | Phase |
|---|---|---|
| PowerShell 7 + PSScriptAnalyzer + Pester | Scripting, lint, tests | P3 |
| DSC (Desired State Configuration) | Config déclarative Windows | P3 |
| Ansible (collections Windows) | Orchestration multi-serveurs | P3 |
| Terraform (+ provider Proxmox bpg) | IaC des VM | P0, P3 |
| Packer | Construction des templates | P0 |
| Ludus | Cyber range as code sur Proxmox (déploie GOAD) | P0, P5 |

---

## 7. Labs & plateformes d'entraînement

- **GOAD (Game of Active Directory)** — Orange Cyberdefense — `https://orange-cyberdefense.github.io/GOAD/` — notre lab offensif. → P5
- **Ludus** — `https://ludus.cloud/` — moteur de déploiement. → P0
- **HackTheBox** — Pro Labs AD + modules AD de HTB Academy. → P5
- **TryHackMe** — parcours Active Directory / Throwback / Wreath. → P1, P5
- **VulnLab** — `https://www.vulnlab.com/` — chaînes AD réalistes. → P5
- **LetsDefend / CyberDefenders** — exercices blue team. → P7

---

## 8. Frameworks & standards

- **MITRE ATT&CK** — `https://attack.mitre.org/` — taxonomie des techniques (à mapper partout). → P5-P9
- **MITRE D3FEND** — contre-mesures. → P7
- **Sigma (SigmaHQ)** — `https://github.com/SigmaHQ/sigma` — format de règles de détection. → P7
- **CIS Benchmarks (Windows Server / Microsoft 365)** — durcissement de référence. → P2, P6
- **ANSSI — Points de contrôle Active Directory** — `https://www.cert.ssi.gouv.fr/` — guide de durcissement AD (FR). → P2, P7

---

## 9. Certifications (pour valoriser l'effort)

| Certification | Organisme | Aligne avec |
|---|---|---|
| CRTP / CRTE | Altered Security | P5 (offensif AD) |
| CRTO | Zero-Point Security | P5, P8 |
| PNPT | TCM Security | P5 |
| OSCP | OffSec | P5 (généraliste) |
| SC-300 | Microsoft | P6 (identité Entra) |
| AZ-500 | Microsoft | P6 (sécurité Azure) |
| Microsoft AD/Windows Server (rôle admin) | Microsoft | P1, P2 |

---

## 10. Veille & communautés

- **r/activedirectory**, **r/PowerShell**, **r/AzureAD** (Reddit)
- **Discord/forums** : BloodHound, TryHackMe, HackTheBox
- **Listes de diffusion / blogs FR** : IT-Connect (`https://www.it-connect.fr/`) pour l'admin Windows en français → P1-P4
- **Veille sécu** : comptes X/Mastodon de SpecterOps, Dirk-jan Mollema, Charlie Bromberg, Sean Metcalf

---

## Comment on s'en sert (méthode)

1. On **ne joint pas** les PDF au dépôt (droit d'auteur + poids Git).
2. Dans un prompt de module, on **pointe un sujet** : *« inspire-toi des thèmes du
   chapitre délégations de* Pentesting AD *— couvre unconstrained, constrained, RBCD »*.
3. Le contenu produit est **original** et pratique, pas une copie du livre.
4. Les docs officielles et blogs ci-dessus servent à **vérifier l'exactitude** et
   l'actualité (Server 2025, dépréciations, nouvelles techniques).
