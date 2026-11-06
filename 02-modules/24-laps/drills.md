# Drills — LAPS

## Drill 1 — Récupérer un mot de passe LAPS (10 min)
- **Étapes** : `Get-LapsADPassword -Identity "PAR-WS-01" -AsPlainText` depuis un compte autorisé.
- **Observer** : mot de passe unique + date d'expiration.
- **Pourquoi** : comprendre le flux de récupération légitime.

## Drill 2 — Rotation (10 min)
- **Étapes** : note le mot de passe, `Reset-LapsPassword`, relis : il a changé.
- **Pourquoi** : voir la rotation automatique/forcée.

## Drill 3 — Qui peut lire ? (10 min)
- **Étapes** : vérifie l'ACL de lecture sur l'OU ; tente la lecture avec un compte non autorisé → échec.
- **Pourquoi** : valider le moindre privilège sur les mots de passe locaux.

## Drill 4 — Chiffrement LAPS (10 min)
- **Étapes** : active le chiffrement pour un groupe précis ; observe `msLAPS-EncryptedPassword`
  (illisible sans le groupe).
- **Pourquoi** : même un lecteur d'annuaire ne voit pas le mot de passe en clair.

## Drill break-fix — Pas de remontée LAPS (10 min)
- **Casse** : retire le self-permission des machines (ou n'étends pas le schéma).
- **Diagnostique** : `Get-LapsADPassword` ne renvoie rien ; vérifie schéma + ACL + GPO.
- **Répare** : réapplique `Set-LapsADComputerSelfPermission`, `gpupdate`, `Invoke-LapsPolicyProcessing`.
