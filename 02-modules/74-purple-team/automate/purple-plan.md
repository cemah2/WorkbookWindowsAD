# Plan de campagne purple — <date>

| Technique ATT&CK | Test (Atomic/Caldera/script) | Règle attendue (module 72) | Alerte ? | Délai | Statut |
|---|---|---|---|---|---|
| T1558.003 Kerberoasting | Invoke-AtomicTest T1558.003 | kerberoasting.yml | ⬜ |  | ⬜ |
| T1003.001 LSASS | Invoke-AtomicTest T1003.001 | lsass-access.yml | ⬜ |  | ⬜ |
| T1003.006 DCSync | script module 56 | dcsync.yml | ⬜ |  | ⬜ |
| T1070.001 Clear log | Invoke-AtomicTest T1070.001 | security-log-cleared.yml | ⬜ |  | ⬜ |
| T1098 RBCD | rbcd-chain.sh (module 53) | rbcd-write.yml | ⬜ |  | ⬜ |
| T1649 ESC8 | module 54 | adcs-machine-cert.yml | ⬜ |  | ⬜ |

> Objectif : passer chaque statut à ✅ (alerte confirmée) et reporter dans coverage.md.
