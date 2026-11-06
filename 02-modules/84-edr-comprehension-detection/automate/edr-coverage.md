# Matrice de couverture EDR / defense-in-depth — à remplir (module 74)

| Technique ATT&CK | EDR kernel | EDR user-mode | Sysmon | SIEM/Sigma | Bloqué ? | Angle mort |
|---|---|---|---|---|---|---|
| T1003.001 LSASS dump | ⬜ | ⬜ | Sysmon 10 | lsass-access.yml | ⬜ |  |
| T1558.003 Kerberoasting | ⬜ | ⬜ | — | kerberoasting.yml | ⬜ |  |
| T1134 Token/Potato | ⬜ | ⬜ | Sysmon 1 | lineage | ⬜ |  |
| T1562.001 ETW/AMSI patch | ⬜ | ⬜ | — | amsi-bypass | ⬜ |  |
| T1068 BYOVD | ⬜ | ⬜ | Sysmon 6 | byovd | ⬜ |  |
| T1055 Injection | ⬜ | ⬜ | Sysmon 8 | — | ⬜ |  |

> Objectif : pour chaque technique, au moins une couche **détecte** (idéalement kernel + comportemental),
> et idéalement une couche **bloque**. Les lignes sans aucune détection = priorité.
