# Fiche — Sysmon (télémétrie endpoint détaillée)

> Volet académique. Sysmon enrichit massivement la visibilité endpoint (process, réseau, fichiers,
> registre, accès mémoire). C'est le carburant de la plupart des règles de détection AD.

## 1. Rôle & utilité
Sysmon (System Monitor, Sysinternals) est un service/driver qui journalise des événements détaillés
dans `Microsoft-Windows-Sysmon/Operational`. Il comble les trous des logs Windows natifs (ex. ligne de
commande complète, hash de process, accès à LSASS, connexions réseau).

## 2. Événements clés (Event IDs Sysmon)
| ID | Événement | Usage détection |
|---|---|---|
| **1** | Process creation | ligne de commande, parent, hash → LOLBins, encoded cmd |
| **3** | Network connection | C2, exfiltration, mouvements |
| **7** | Image/DLL loaded | DLL sideloading |
| **8** | CreateRemoteThread | injection |
| **10** | **ProcessAccess** | **accès à LSASS** (dump de creds, module 56) |
| **11** | FileCreate | drops, MOF, outils |
| **12/13/14** | Registry | persistance, modif de clés |
| **15** | FileCreateStreamHash | ADS, mark-of-the-web |
| **22** | DNSQuery | résolution suspecte (C2) |
| **25** | Process Tampering | évasion |

## 3. La configuration = tout
Sysmon sans config = bruit. On déploie une **configuration** éprouvée (ex. **SwiftOnSecurity**,
**Olaf Hartong modular config**) qui filtre le bruit et cible l'essentiel (incl. règle « accès à
lsass.exe »). La config se versionne et s'affine.

## 4. Déploiement
- `sysmon -i config.xml` (install), `-c config.xml` (mettre à jour la config). À l'échelle : GPO/
  Ansible/DSC + mise à jour centralisée de la config. Forward du canal vers le SIEM (module 70).

## 5. Lien avec les attaques du workbook
- **Sysmon 10** → dump LSASS (module 56), Mimikatz.
- **Sysmon 1** → PowerShell encodé (module 30), vssadmin (module 29), reg save (module 56).
- **Sysmon 11** → MOF DSC malveillant (module 32), drops d'outils.
- **Sysmon 3/22** → C2/exfiltration.

## 6. Objets/éléments liés
- Service/driver Sysmon, canal Operational, fichier de configuration (XML).

## 7. Surface d'attaque (côté défense)
Les attaquants tentent de **désactiver/désinstaller Sysmon** ou de **patcher ETW**. D'où : protéger le
service, surveiller son arrêt, et compléter par l'EDR.

## 8. Détection de l'altération de Sysmon
Arrêt/désinstallation du service Sysmon, modification de sa config, Sysmon 255 (erreurs). Voir `defend.md`.

## 9. Versioning
Sysmon évolue (nouveaux IDs). Les configs communautaires sont régulièrement mises à jour — suivre.

## 10. Pour aller plus loin
Sysinternals (Sysmon), SwiftOnSecurity/Olaf Hartong configs. Voir `99-ressources/bibliographie.md` (P7).
