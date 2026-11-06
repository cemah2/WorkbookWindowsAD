# Drills — Dump de credentials

## Drill 1 — DCSync de krbtgt (10 min)
- **Étapes** : `secretsdump -just-dc-user krbtgt` (avec droits).
- **Observer** : le hash krbtgt (clé des Golden Tickets, module 57).
- **Pourquoi** : la cible ultime de la dominance.

## Drill 2 — LSASS → PtH (15 min)
- **Étapes** : dump LSASS (lsassy/mimikatz), récupère un hash, `nxc smb -H`.
- **Pourquoi** : la boucle vol → réutilisation.

## Drill 3 — SAM local (10 min)
- **Étapes** : `secretsdump` local, repère les comptes locaux + LSA secrets.
- **Pourquoi** : sources locales de credentials.

## Drill 4 — OverPass-the-Hash (10 min)
- **Étapes** : hash NT → `getTGT -hashes` → utiliser le TGT.
- **Pourquoi** : passer de NTLM à Kerberos.

## Drill break-fix — Credential Guard bloque (10 min)
- **Casse** : active Credential Guard sur la cible (lab).
- **Diagnostique** : LSASS ne livre plus de secrets exploitables.
- **Répare/comprends** : c'est la défense ; compare avec/sans.
