# Matrice de couverture ATT&CK (détection) — à tenir à jour

| Technique ATT&CK | Règle Sigma | Source log | Statut (prouvée ?) | Module |
|---|---|---|---|---|
| T1558.003 Kerberoasting | kerberoasting.yml | Security 4769 | ⬜ | 52 |
| T1098 RBCD | rbcd-write.yml | Security 5136 | ⬜ | 53 |
| T1649 ESC8 | adcs-machine-cert.yml | Security 4886 | ⬜ | 43/54 |
| T1003.001 LSASS | lsass-access.yml | Sysmon 10 | ⬜ | 56 |
| T1003.006 DCSync | dcsync.yml | Security 4662 | ⬜ | 26/56 |
| T1070.001 Clear log | security-log-cleared.yml | Security 1102 | ⬜ | 70 |

> Statut passe à ✅ quand la règle a été **déclenchée** par un rejeu (module 74).
> Compléter avec : AS-REP (4768), Shadow Creds (5136 KeyCredentialLink), AdminSDHolder (5136),
> sIDHistory (4765/4766), vssadmin (T1490), encoded PowerShell (4104), WinRM (wsmprovhost),
> et les détections hybrides (KQL : consent, role add, break-glass).
