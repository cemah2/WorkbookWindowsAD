# Bibliothèque de hunts (hypothèses ATT&CK) — à adapter au backend SIEM

## Credential Access
- Kerberoasting (T1558.003) : 4769 EncryptionType=0x17, group by account, count>10
- AS-REP (T1558.004) : 4768 PreAuthType=0
- DCSync (T1003.006) : 4662 GUID 1131f6aa.../1131f6ad... depuis IP non-DC
- LSASS access (T1003.001) : Sysmon 10 TargetImage=lsass.exe, GrantedAccess suspect

## Privilege Escalation / Persistence
- RBCD (T1098) : 5136 attribut msDS-AllowedToActOnBehalfOfOtherIdentity
- Shadow Creds : 5136 attribut msDS-KeyCredentialLink
- AdminSDHolder : 5136 ObjectDN contient CN=AdminSDHolder
- ESC8 : 4886 Requester se terminant par $

## Defense Evasion
- Clear log (T1070.001) : 1102
- Sysmon tampering : Sysmon 16 / service arrêté (7034)
- Encoded PowerShell : 4104 / Sysmon 1 -enc

## Lateral Movement / Tiering
- Violation tiering : 4624 compte adm-t0-* sur hôte non-T0
- WinRM : Sysmon 1 ParentImage=wsmprovhost.exe

## Rareté (least-frequency)
- Sysmon 1 : process/hash/parent rares
- Sysmon 3/22 : destinations réseau/DNS uniques
