# Drills — OU & délégation

## Drill 1 — Lire les ACE d'une OU (10 min)
- **Étapes** : `(Get-Acl "AD:<DN de l'OU>").Access | ? {-not $_.IsInherited}`.
- **Observer** : qui a quels droits, hérités ou non.
- **Pourquoi** : savoir auditer une délégation.

## Drill 2 — Déléguer puis tester (15 min)
- **Étapes** : délègue "Reset Password" sur une OU à un groupe ; teste avec un membre (succès)
  et hors périmètre (échec).
- **Pourquoi** : vérifier le moindre privilège par la pratique.

## Drill 3 — GenericAll, l'ACE dangereuse (10 min)
- **Étapes** : accorde temporairement *GenericAll* à un user de test sur un autre objet, observe
  dans BloodHound/`Get-Acl` ce que ça autorise (reset pwd, shadow creds, etc.), puis retire-le.
- **Pourquoi** : comprendre pourquoi les ACL excessives = escalade.

## Drill 4 — AdminSDHolder / SDProp (10 min)
- **Étapes** : pose une ACE sur un membre de "Domain Admins", attends le cycle SProp (ou force),
  constate qu'elle disparaît.
- **Pourquoi** : comprendre la protection des comptes sensibles.

## Drill break-fix — Délégation trop large (10 min)
- **Casse** : délègue "Full Control" sur une OU à un groupe support.
- **Diagnostique** : `Get-Acl` révèle GenericAll ; BloodHound montre un chemin d'escalade.
- **Répare** : remplace par la seule tâche nécessaire (Reset Password), re-audite.
