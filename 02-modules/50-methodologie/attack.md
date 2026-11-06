# Attack — La méthodologie en action (fil rouge)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Ce module ne contient pas d'exploit : il **orchestre** les
> suivants (51-58) selon le cycle d'intrusion.

## Fil rouge (assumed breach dans GOAD-X)
1. **Recon/Enum** (module 51) : BloodHound + énumération → repérer les cibles (SPN, ACL, délégations, ESC).
2. **Credential access / escalation** : Kerberoasting (52), ACL (21), ESC (43), coercition (54),
   Shadow Credentials (55).
3. **Lateral movement** (53, 56) : PtH/PtT, délégations, dump de creds.
4. **Domain dominance** : DCSync → krbtgt.
5. **Persistence** (57) : Golden Ticket, certificats, ACL.
6. **Cross-forest** (58) : trusts, SID history.

## MITRE ATT&CK
À chaque étape, consigner tactique + technique dans le journal (base du rapport et de la détection).

## Ancrage réel
Ce cycle reflète les intrusions réelles (IR/threat intel) : la méthodologie du workbook suit la
logique d'un opérateur, pour mieux la détecter.

## Résultat attendu
Un chemin d'attaque **documenté** de bout en bout, prêt à être transformé en rapport + détections.
